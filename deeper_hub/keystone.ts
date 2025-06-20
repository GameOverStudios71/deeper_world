// Welcome to Keystone!
//
// This file is what Keystone uses as the entry-point to your headless backend
//
// Keystone imports the default export of this file, expecting a Keystone configuration object
//   you can find out more at https://keystonejs.com/docs/apis/config

import { config } from '@keystone-6/core';
import { json } from 'express';
import * as bcrypt from 'bcryptjs';
import * as forge from 'node-forge';
import axios from 'axios';
import { getOrCreateCA, generateServerCertificate } from './lib/pki';

// to keep this file tidy, we define our schema in a different file
import { lists } from './schema'

// authentication is configured separately here too, but you might move this elsewhere
// when you write your list-level access control functions, as they typically rely on session data
import { withAuth, session } from './auth'

export default withAuth(
  config({
    db: {
      provider: 'sqlite',
      url: 'file:./deeper_hub.db',
    },
    lists,
    session,
    server: {
      extendExpressApp: (app, context) => {
        // Adiciona um middleware para parsear o corpo da requisição como JSON
        app.use(json());

        // Inicializa a Autoridade Certificadora na inicialização
        const ca = getOrCreateCA();

        // Endpoint para registrar um novo servidor e obter um certificado
        app.post('/api/register-server', async (req, res) => {
          console.log('Recebida requisição em /api/register-server');

          const { email, password, serverName, serverUrl } = req.body;

          if (!email || !password || !serverName || !serverUrl) {
            return res.status(400).json({ error: 'Parâmetros ausentes.' });
          }

          try {
            // Autentica o usuário usando o cliente Prisma para acesso direto ao DB
            const user = await context.prisma.user.findUnique({ where: { email } });

            if (!user) {
              return res.status(401).json({ error: 'Usuário não encontrado.' });
            }

            // A senha do usuário está hasheada, então usamos bcrypt para comparar
            const isPasswordValid = user.password && (await bcrypt.compare(password, user.password));

            if (!isPasswordValid) {
              return res.status(401).json({ error: 'Senha inválida.' });
            }

            // Gera o certificado para o servidor
            const serverCreds = generateServerCertificate(serverName, ca);

            // Lógica de Upsert: atualiza o servidor se ele existir, ou cria um novo.
            await context.prisma.server.upsert({
              where: { name: serverName },
              update: {
                url: serverUrl,
                certificate: serverCreds.certificate,
                owner: { connect: { id: user.id } },
              },
              create: {
                name: serverName,
                url: serverUrl,
                owner: { connect: { id: user.id } },
                status: 'offline', // Começa como offline
                certificate: serverCreds.certificate, // Salva o certificado PEM
              },
            });

            console.log(`Registro/Atualização do servidor '${serverName}' concluído com sucesso para o usuário ${email}.`);

            // Retorna as credenciais para o deeper_server
            res.json(serverCreds);
          } catch (error) {
            console.error('Erro ao registrar servidor:', error);
            res.status(500).json({ error: 'Erro interno do servidor.' });
          }
        });

        // Endpoint para o servidor notificar que está online (heartbeat com assinatura)
        app.post('/api/heartbeat', async (req, res) => {
          const { serverName, timestamp, signature } = req.body;

          if (!serverName || !timestamp || !signature) {
            return res.status(400).json({ error: 'Parâmetros ausentes: serverName, timestamp, signature são obrigatórios.' });
          }

          // Prevenção de Replay Attack: verificar se o timestamp não é muito antigo (ex: 5 minutos)
          const now = Date.now();
          const requestTime = new Date(timestamp).getTime();
          if (isNaN(requestTime) || now - requestTime > 300000) { // 5 minutos
            return res.status(400).json({ error: 'Timestamp inválido ou expirado.' });
          }

          try {
            // Busca o servidor e seu certificado no banco de dados
            const server = await context.query.Server.findOne({
              where: { name: serverName },
              query: 'id certificate',
            });

            if (!server || !server.certificate) {
              return res.status(404).json({ error: `Servidor '${serverName}' ou seu certificado não encontrado.` });
            }

            // Recria a mensagem original que foi assinada
            const message = `${serverName}${timestamp}`;

            // Verifica a assinatura
            const cert = forge.pki.certificateFromPem(server.certificate as string);
            const publicKey = cert.publicKey;
            const md = forge.md.sha256.create();
            md.update(message, 'utf8');
            const signatureBytes = forge.util.decode64(signature);

            const verified = (publicKey as forge.pki.rsa.PublicKey).verify(md.digest().bytes(), signatureBytes);

            if (!verified) {
              return res.status(401).json({ error: 'Assinatura inválida.' });
            }

            // Se a assinatura for válida, atualiza o status
            await context.query.Server.updateOne({
              where: { id: server.id },
              data: { status: 'online' },
            });

            console.log(`Heartbeat verificado de ${serverName}. Status atualizado para online.`);
            res.json({ message: 'Heartbeat recebido e verificado com sucesso.' });
          } catch (error) {
            console.error('Erro no heartbeat:', error);
            res.status(500).json({ error: 'Erro interno do servidor.' });
          }
        });

        // Rota para um cliente reportar que um servidor parece estar offline
        app.post('/api/report-server-down', async (req, res) => {
          const { serverName } = req.body;
          if (!serverName) {
            return res.status(400).json({ error: 'O nome do servidor é obrigatório.' });
          }

          console.log(`Recebido relatório de inatividade para o servidor: ${serverName}`);

          try {
            const server = await context.prisma.server.findUnique({ where: { name: serverName } });

            if (!server) {
              return res.status(404).json({ error: 'Servidor não encontrado.' });
            }

            // O servidor já está offline, não fazer nada
            if (server.status === 'offline') {
              return res.json({ message: 'O status do servidor já era offline.' });
            }

            // Tentar acessar o endpoint de health check do servidor para confirmar se está offline
            const healthCheckUrl = new URL('/api/health', server.url).toString();
            await axios.get(healthCheckUrl, { timeout: 5000 }); // Timeout de 5 segundos

            // Se chegamos aqui, o servidor respondeu. O relatório era um falso positivo.
            console.log(`Relatório de inatividade para ${serverName} foi um falso positivo. O servidor está online.`);
            res.json({ message: 'Verificação concluída. O servidor está online.' });

          } catch (error) {
            // Se axios falhou (timeout, erro de conexão, etc), o servidor está realmente offline.
            console.log(`Verificação confirmou que ${serverName} está offline. Atualizando status.`);
            console.error('Erro detalhado na verificação do axios:', error);
            await context.prisma.server.update({
              where: { name: serverName },
              data: { status: 'offline' },
            });
            res.json({ message: `O servidor ${serverName} foi marcado como offline.` });
          }
        });
      },
    },
  })
);

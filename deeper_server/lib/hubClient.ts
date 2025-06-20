import axios from 'axios';
import * as forge from 'node-forge';
import * as fs from 'fs';
import * as path from 'path';
import * as readline from 'readline/promises';

const pki = forge.pki;

// URL do Deeper Hub. Em um cenário real, isso viria de uma variável de ambiente.
const HUB_URL = 'http://localhost:3000';

// Caminho para salvar as credenciais
const credsPath = path.join(process.cwd(), '.credentials', 'creds.json');

interface ServerCredentials {
  certificate: string;
  privateKey: string;
  publicKey: string;
  serial: string;
  caCert: string;
}

// Função para salvar as credenciais em um arquivo
function saveCredentials(creds: ServerCredentials): void {
  const dirPath = path.dirname(credsPath);
  if (!fs.existsSync(dirPath)) {
    fs.mkdirSync(dirPath, { recursive: true });
  }
  fs.writeFileSync(credsPath, JSON.stringify(creds, null, 2));
  console.log(`Credenciais salvas em ${credsPath}`);
}

// Função para carregar as credenciais de um arquivo
function loadCredentials(): ServerCredentials | null {
  if (fs.existsSync(credsPath)) {
    const data = fs.readFileSync(credsPath, 'utf8');
    return JSON.parse(data);
  }
  return null;
}

// Função para registrar este servidor com o Hub
async function registerWithHub(serverName: string): Promise<ServerCredentials | null> {
  const rl = readline.createInterface({ input: process.stdin, output: process.stdout });

  try {
    console.log('--- Registro no Deeper Hub ---');
    const email = await rl.question('Digite o email do seu usuário no Deeper Hub: ');
    const password = await rl.question('Digite a senha: ', { hideEchoBack: true } as any);
    console.log('\n');

    const response = await axios.post(`${HUB_URL}/api/register-server`, {
      email,
      password,
      serverName,
      serverUrl: 'http://localhost:3001', // URL correta do servidor local
    });

    if (response.data && response.data.certificate) {
      console.log('Registro bem-sucedido!');
      return response.data;
    }
  } catch (error: any) {
    console.error('Falha no registro:', error.response?.data?.error || error.message);
  } finally {
    rl.close();
  }
  return null;
}

// Função para enviar um heartbeat assinado para o Hub
async function sendHeartbeat(serverName: string, creds: ServerCredentials): Promise<boolean> {
  try {
    const privateKey = pki.privateKeyFromPem(creds.privateKey);
    const timestamp = new Date().toISOString();
    const message = `${serverName}${timestamp}`;

    const md = forge.md.sha256.create();
    md.update(message, 'utf8');

    const signature = privateKey.sign(md);
    const signature64 = forge.util.encode64(signature);

    await axios.post(`${HUB_URL}/api/heartbeat`, {
      serverName,
      timestamp,
      signature: signature64,
    });

    console.log(`Heartbeat enviado com sucesso para o Deeper Hub. (${timestamp})`);
    return true;
  } catch (error: any) {
    // Não exibir o erro completo aqui, apenas uma mensagem de que a tentativa falhou.
    console.log('Falha ao enviar heartbeat. Verificando se o Deeper Hub está online...');
    return false;
  }
}

// Função principal de inicialização
export async function initializeHubConnection(serverName: string): Promise<void> {
  let creds = loadCredentials();

  if (!creds) {
    console.log('Nenhuma credencial local encontrada. Iniciando processo de registro...');
    creds = await registerWithHub(serverName);
    if (creds) {
      saveCredentials(creds);
    } else {
      console.error('Não foi possível obter as credenciais do Hub. O servidor não pode notificar seu status online.');
      return;
    }
  }

  // Envia o primeiro heartbeat na inicialização, com retentativas.
  console.log('Tentando notificar o Deeper Hub que o servidor está online...');
  let heartbeatSent = false;
  while (!heartbeatSent) {
    heartbeatSent = await sendHeartbeat(serverName, creds!);
    if (!heartbeatSent) {
      console.log('Não foi possível conectar ao Deeper Hub. Nova tentativa em 5 segundos...');
      await new Promise(resolve => setTimeout(resolve, 5000)); // Espera 5 segundos
    }
  }
}

import forge from 'node-forge';
import fs from 'fs';
import path from 'path';

const pki = forge.pki;

// Define os caminhos para o certificado e chave da CA
const caCertPath = path.join(process.cwd(), '.pki', 'ca.crt');
const caKeyPath = path.join(process.cwd(), '.pki', 'ca.key');

export interface CA {
  cert: forge.pki.Certificate;
  privateKey: forge.pki.PrivateKey;
}

export interface ServerCredentials {
  certificate: string;
  privateKey: string;
  publicKey: string;
  serial: string;
  caCert: string;
}

// Função para obter ou criar a Autoridade Certificadora
export function getOrCreateCA(): CA {
  // Garante que o diretório .pki exista
  if (!fs.existsSync(path.dirname(caCertPath))) {
    fs.mkdirSync(path.dirname(caCertPath));
  }

  // Se o certificado e a chave da CA já existirem, carrega-os
  if (fs.existsSync(caCertPath) && fs.existsSync(caKeyPath)) {
    const certPem = fs.readFileSync(caCertPath, 'utf8');
    const keyPem = fs.readFileSync(caKeyPath, 'utf8');
    return {
      cert: pki.certificateFromPem(certPem),
      privateKey: pki.privateKeyFromPem(keyPem),
    };
  }

  // Caso contrário, cria uma nova CA
  const keys = pki.rsa.generateKeyPair(2048);
  const cert = pki.createCertificate();
  cert.publicKey = keys.publicKey;
  cert.serialNumber = '01';
  cert.validity.notBefore = new Date();
  cert.validity.notAfter = new Date();
  cert.validity.notAfter.setFullYear(cert.validity.notBefore.getFullYear() + 10); // Validade de 10 anos

  const attrs = [
    { name: 'commonName', value: 'DeeperHub CA' },
    { name: 'countryName', value: 'BR' },
    { name: 'stateOrProvinceName', value: 'SP' },
    { name: 'localityName', value: 'Sao Paulo' },
    { name: 'organizationName', value: 'Deeper World' },
    { name: 'organizationalUnitName', value: 'DeeperHub' },
  ];
  cert.setSubject(attrs);
  cert.setIssuer(attrs); // Auto-assinado
  cert.setExtensions([
    { name: 'basicConstraints', cA: true },
    { name: 'keyUsage', keyCertSign: true, digitalSignature: true, nonRepudiation: true, keyEncipherment: true, dataEncipherment: true },
  ]);

  // Auto-assina o certificado
  cert.sign(keys.privateKey, forge.md.sha256.create());

  // Salva o certificado e a chave da CA em arquivos
  fs.writeFileSync(caCertPath, pki.certificateToPem(cert));
  fs.writeFileSync(caKeyPath, pki.privateKeyToPem(keys.privateKey));

  console.log('Nova Autoridade Certificadora criada.');

  return { cert, privateKey: keys.privateKey };
}

// Função para gerar um certificado para um servidor
export function generateServerCertificate(serverName: string, ca: CA): ServerCredentials {
  const serverKeys = pki.rsa.generateKeyPair(2048);
  const cert = pki.createCertificate();
  cert.publicKey = serverKeys.publicKey;
  cert.serialNumber = new Date().getTime().toString(); // Usa timestamp para um serial único
  cert.validity.notBefore = new Date();
  cert.validity.notAfter = new Date();
  cert.validity.notAfter.setFullYear(cert.validity.notBefore.getFullYear() + 1); // Validade de 1 ano

  const attrs = [
    { name: 'commonName', value: serverName },
    { name: 'countryName', value: 'BR' },
    { name: 'stateOrProvinceName', value: 'SP' },
    { name: 'localityName', value: 'Sao Paulo' },
    { name: 'organizationName', value: 'Deeper World' },
    { name: 'organizationalUnitName', value: 'DeeperServer' },
  ];
  cert.setSubject(attrs);
  cert.setIssuer(ca.cert.subject.attributes); // Emitido pela nossa CA

  cert.setExtensions([
    { name: 'basicConstraints', cA: false },
    { name: 'keyUsage', digitalSignature: true, keyEncipherment: true },
    { name: 'extKeyUsage', serverAuth: true, clientAuth: true }, // Importante para mTLS
    { name: 'subjectAltName', altNames: [{ type: 6, value: `dns:${serverName}` }] },
  ]);

  // Assina com a chave da CA
  cert.sign(ca.privateKey, forge.md.sha256.create());

  return {
    certificate: pki.certificateToPem(cert),
    privateKey: pki.privateKeyToPem(serverKeys.privateKey),
    publicKey: pki.publicKeyToPem(serverKeys.publicKey),
    serial: cert.serialNumber,
    caCert: pki.certificateToPem(ca.cert),
  };
}

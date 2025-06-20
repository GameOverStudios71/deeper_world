// Welcome to Keystone!
//
// This file is what Keystone uses as the entry-point to your headless backend
//
// Keystone imports the default export of this file, expecting a Keystone configuration object
//   you can find out more at https://keystonejs.com/docs/apis/config

import { config } from '@keystone-6/core';
import { initializeHubConnection } from './lib/hubClient';

// to keep this file tidy, we define our schema in a different file
import { lists } from './schema'

// Authentication is handled by Deeper Hub.

export default config({
  server: {
    port: 3001,
    extendExpressApp: (app) => {
      app.get('/api/health', (req, res) => {
        res.json({ status: 'ok' });
      });
    },
  },
  db: {
    // we're using sqlite for the fastest startup experience
    //   for more information on what database might be appropriate for you
    //   see https://keystonejs.com/docs/guides/choosing-a-database#title
    provider: 'sqlite',
    url: 'file:./keystone.db',
    onConnect: async () => {
      // O nome deste servidor. Em um cenário real, isso viria de um arquivo de configuração.
      const thisServerName = 'deeper-server-instance-1';
      console.log(`🚀 Servidor ${thisServerName} conectado ao banco de dados.`);
      await initializeHubConnection(thisServerName);
    },
  },
  lists,
});

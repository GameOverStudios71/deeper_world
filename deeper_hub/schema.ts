// Welcome to your schema
//   Schema driven development is Keystone's modus operandi
//
// This file is where we define the lists, fields and hooks for our data.
// If you want to learn more about how lists are configured, please read
// - https://keystonejs.com/docs/config/lists

import { list } from '@keystone-6/core';
import { allowAll } from '@keystone-6/core/access';
import {
  text,
  relationship,
  password,
  timestamp,
  select,
} from '@keystone-6/core/fields';
import { type Lists } from '.keystone/types';

export const lists = {
  User: list({
    access: allowAll,
    fields: {
      name: text({ validation: { isRequired: true } }),
      email: text({
        validation: { isRequired: true },
        isIndexed: 'unique',
      }),
      password: password({ validation: { isRequired: true } }),
      // A user can own multiple servers
      servers: relationship({ ref: 'Server.owner', many: true }),
      createdAt: timestamp({
        defaultValue: { kind: 'now' },
      }),
    },
  }),

  Server: list({
    access: allowAll,
    fields: {
      name: text({ validation: { isRequired: true } }),
      url: text({
        validation: { isRequired: true },
        isIndexed: 'unique',
      }),
      description: text(),
      // Each server is owned by one user
      owner: relationship({
        ref: 'User.servers',
        ui: {
          displayMode: 'cards',
          cardFields: ['name', 'email'],
          inlineEdit: { fields: ['name', 'email'] },
          linkToItem: true,
          inlineConnect: true,
        },
        many: false,
      }),
      certificate: text({ ui: { displayMode: 'textarea' } }),
      status: select({
        options: [
          { label: 'Online', value: 'online' },
          { label: 'Offline', value: 'offline' },
        ],
        defaultValue: 'offline',
        ui: { displayMode: 'segmented-control' },
      }),
    },
  }),
} satisfies Lists;

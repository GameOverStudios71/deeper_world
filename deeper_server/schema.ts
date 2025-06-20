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
  timestamp,
} from '@keystone-6/core/fields';
import { grapesJsField } from './custom-fields/grapesjs';
import { type Lists } from '.keystone/types';

export const lists = {
  Page: list({
    access: allowAll,
    fields: {
      title: text({ validation: { isRequired: true } }),
      // The GrapesJS field for rich content
      content: grapesJsField(),
      slug: text({
        validation: { isRequired: true },
        isIndexed: 'unique',
      }),
      createdAt: timestamp({
        defaultValue: { kind: 'now' },
      }),
    },
  }),
} satisfies Lists;

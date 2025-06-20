import {
  fieldType,
  FieldTypeFunc,
  CommonFieldConfig,
  BaseListTypeInfo,
} from '@keystone-6/core/types';
import { graphql } from '@keystone-6/core';

export type GrapesJsFieldConfig<ListTypeInfo extends BaseListTypeInfo> =
  CommonFieldConfig<ListTypeInfo>;

export function grapesJsField<ListTypeInfo extends BaseListTypeInfo>(
  config: GrapesJsFieldConfig<ListTypeInfo> = {}
): FieldTypeFunc<ListTypeInfo> {
  return meta =>
    fieldType({
      kind: 'scalar',
      mode: 'optional',
      scalar: 'String', // Store as a String in the database
    })({
      ...config,
      input: {
        create: {
          arg: graphql.arg({ type: graphql.JSON }),
          // When receiving data from the client, stringify it before saving
          resolve(value) {
            return value === null || value === undefined ? null : JSON.stringify(value);
          },
        },
        update: {
          arg: graphql.arg({ type: graphql.JSON }),
          // When receiving data from the client, stringify it before saving
          resolve(value) {
            return value === null || value === undefined ? null : JSON.stringify(value);
          },
        },
      },
      output: graphql.field({
        type: graphql.JSON,
        // When sending data to the client, parse it from a string
        resolve({ value }) {
          if (typeof value === 'string') {
            try {
              return JSON.parse(value);
            } catch (e) {
              return null;
            }
          }
          return value;
        },
      }),
      views: './custom-fields/grapesjs/views',
      getAdminMeta: () => ({}),
    });
}

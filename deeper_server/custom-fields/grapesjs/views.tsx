/** @jsxRuntime classic */
/** @jsx jsx */
import { jsx } from '@keystone-ui/core';
import { FieldContainer, FieldLabel } from '@keystone-ui/fields';
import {
  FieldProps,
  FieldController,
  FieldControllerConfig,
} from '@keystone-6/core/types';
import {
  CellLink,
  CellComponent,
  CardValueComponent,
} from '@keystone-6/core/admin-ui/components';
import { useEffect, useRef } from 'react';
import 'grapesjs/dist/css/grapes.min.css';
import GrapesJS from 'grapesjs';
import grapesjsPresetWebpage from 'grapesjs-preset-webpage';

type GrapesJsValue = {
  html: string;
  css: string;
} | null;

export const Field = ({
  field,
  value,
  onChange,
}: FieldProps<typeof controller>) => {
  const editorRef = useRef<any>(null);
  const editorElRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    if (editorElRef.current && !editorRef.current) {
      const editor = GrapesJS.init({
        container: editorElRef.current,
        fromElement: false,
        storageManager: false,
        plugins: [grapesjsPresetWebpage],
        pluginsOpts: {
          'gjs-preset-webpage': {},
        },
      });

      if (
        value &&
        typeof value === 'object' &&
        value !== null &&
        'html' in value
      ) {
        const data = value as GrapesJsValue;
        if (data?.html) editor.setComponents(data.html);
        if (data?.css) editor.setStyle(data.css);
      }

      const handleUpdate = () => {
        if (onChange) {
          const html = editor.getHtml() || '';
          const css = editor.getCss() || '';
          onChange({ html, css });
        }
      };

      editor.on('update', handleUpdate);
      editorRef.current = editor;
    }

    return () => {
      if (editorRef.current) {
        editorRef.current.destroy();
        editorRef.current = null;
      }
    };
  }, [editorElRef, onChange]);

  useEffect(() => {
    if (editorRef.current && value) {
      const editor = editorRef.current;
      const editorHtml = editor.getHtml();
      const editorCss = editor.getCss();

      if (
        JSON.stringify({ html: editorHtml, css: editorCss }) !==
        JSON.stringify(value)
      ) {
        if (
          typeof value === 'object' &&
          value !== null &&
          'html' in value
        ) {
          const data = value as GrapesJsValue;
          if (data?.html) editor.setComponents(data.html);
          if (data?.css) editor.setStyle(data.css);
        } else {
          editor.setComponents('');
          editor.setStyle('');
        }
      }
    }
  }, [value]);

  useEffect(() => {
    // Atraso para garantir que o DOM esteja totalmente renderizado
    setTimeout(() => {
      // Assumindo que os nomes dos campos no schema são 'title' e 'slug'
      const titleInput = document.querySelector<HTMLInputElement>('input[id="title"]');
      const slugInput = document.querySelector<HTMLInputElement>('input[id="slug"]');

      if (!titleInput || !slugInput) {
        console.log('Deeper World Slugify: Inputs de Título ou Slug não encontrados.');
        return;
      }

      const gerarSlug = (texto: string) => {
        if (!texto) return '';
        return texto
          .toString()
          .toLowerCase()
          .normalize('NFD') // Separa acentos das letras
          .replace(/[\u0300-\u036f]/g, '') // Remove acentos
          .replace(/\s+/g, '_') // Substitui espaços por _
          .replace(/[^\w_]+/g, '') // Remove caracteres não alfanuméricos (exceto _)
          .replace(/__+/g, '_'); // Substitui múltiplos _ por um só
      };

      const handleTitleChange = (event: Event) => {
        if (slugInput && event.target) {
          const titleValue = (event.target as HTMLInputElement).value;
          const slugValue = gerarSlug(titleValue);

          // Simula a entrada do usuário para que o React atualize o estado
          const nativeInputValueSetter = Object.getOwnPropertyDescriptor(
            window.HTMLInputElement.prototype,
            'value'
          )?.set;
          nativeInputValueSetter?.call(slugInput, slugValue);

          const inputEvent = new Event('input', { bubbles: true });
          slugInput.dispatchEvent(inputEvent);
        }
      };

      // Evita adicionar o mesmo listener múltiplas vezes
      if (!titleInput.dataset.slugListenerAttached) {
        titleInput.addEventListener('input', handleTitleChange);
        titleInput.dataset.slugListenerAttached = 'true';
      }
    }, 500); // 500ms de atraso
  }, []);

  return (
    <FieldContainer>
      <FieldLabel htmlFor={field.path}>{field.label}</FieldLabel>
      <div css={{ height: '800px', border: '1px solid #ccc' }}>
        <div ref={editorElRef} />
      </div>
    </FieldContainer>
  );
};

export const Cell: CellComponent<typeof controller> = ({
  item,
  field,
  linkTo,
}) => {
  const value = item[field.path];
  const label = value ? '[Page Content]' : '';
  if (linkTo) {
    return <CellLink {...linkTo}>{label}</CellLink>;
  }
  return <span>{label}</span>;
};

export const CardValue: CardValueComponent<typeof controller> = ({
  item,
  field,
}) => {
  const value = item[field.path];
  return (
    <FieldContainer>
      <FieldLabel>{field.label}</FieldLabel>
      {value ? '[Page Content]' : ''}
    </FieldContainer>
  );
};

export const controller = (
  config: FieldControllerConfig<GrapesJsValue>
): FieldController<GrapesJsValue, GrapesJsValue> => {
  return {
    path: config.path,
    label: config.label,
    description: config.description,
    graphqlSelection: config.path,
    defaultValue: null,
    deserialize: item => {
      return item[config.path] || null;
    },
    serialize: value => {
      return { [config.path]: value };
    },
  };
};

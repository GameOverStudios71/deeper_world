# Guia para Criação de Novos Módulos no Projeto Deeper Hub

Este documento serve como um guia e checklist para garantir que novos módulos LiveView sejam criados de forma consistente e correta, com base nas lições aprendidas durante o desenvolvimento.

## Passo 1: Geração do Módulo com `phx.gen.live`

A base de qualquer novo CRUD é o gerador do Phoenix.

### Tabelas Simples (sem relacionamentos)

Para uma tabela simples como `Categories`, que só precisa de um nome:

```bash
mix phx.gen.live Hub Category categories name:string
```

### Tabelas Complexas (com relacionamentos)

Para tabelas que se relacionam com outras (como a tabela `servers`), use a opção `references` para que o Phoenix já crie a migração com a chave estrangeira correta.

**Exemplo:**

```bash
mix phx.gen.live Hub Server servers \
  server_name:string \
  url:string \
  # ... outros campos ... \
  category_id:references:categories \
  language_id:references:languages \
  owner_id:references:users
```

## Passo 2: Configuração das Rotas

Este é um passo **crítico** e uma fonte comum de erros.

1.  Abra o arquivo `lib/deeper_hub_web/router.ex`.
2.  Localize o escopo de autenticação **obrigatória**. Ele se parece com isto:

    ```elixir
    scope "/", DeeperHubWeb do
      pipe_through [:browser, :require_authenticated_user]

      live_session :require_authenticated_user,
        on_mount: [{DeeperHubWeb.UserAuth, :ensure_authenticated}] do
        # ... outras rotas autenticadas aqui ...
      end
    end
    ```

3.  **Adicione TODAS as novas rotas do LiveView DENTRO deste bloco `live_session`**. Não as coloque em nenhum outro lugar.

    ```elixir
    # ...
    live_session :require_authenticated_user,
      on_mount: [{DeeperHubWeb.UserAuth, :ensure_authenticated}] do
      live "/users/settings", UserSettingsLive, :edit
      # ...

      # ADICIONE AS NOVAS ROTAS AQUI
      live "/categories", CategoryLive.Index, :index
      live "/categories/new", CategoryLive.Index, :new
      live "/categories/:id/edit", CategoryLive.Index, :edit
      live "/categories/:id", CategoryLive.Show, :show
      live "/categories/:id/show/edit", CategoryLive.Show, :edit
    end
    # ...
    ```

## Passo 3: Migração do Banco de Dados

Após gerar os módulos e configurar as rotas, aplique as migrações:

```bash
mix ecto.migrate
```

## Passo 4: Ajustes no Schema para Relacionamentos

Para que o Ecto entenda os relacionamentos e para que possamos usar dropdowns, precisamos ajustar o schema do módulo principal (ex: `Server`).

1.  Abra o arquivo do schema (ex: `lib/deeper_hub/hub/server.ex`).
2.  Substitua os campos `_id` por `belongs_to`.

    **Antes:**
    ```elixir
    field :category_id, :id
    field :language_id, :id
    ```

    **Depois:**
    ```elixir
    belongs_to :category, DeeperHub.Hub.Category
    belongs_to :language, DeeperHub.Hub.Language
    # Para o usuário, o caminho do módulo é diferente:
    belongs_to :owner, DeeperHub.Accounts.User, foreign_key: :owner_id
    ```

3.  Atualize a função `changeset` para incluir os campos `_id` e as validações de chave estrangeira.

    ```elixir
    def changeset(server, attrs) do
      server
      |> cast(attrs, [
        # ... outros campos ...
        :category_id,
        :language_id,
        :owner_id
      ])
      |> validate_required([
        # ... outros campos obrigatórios ...
        :category_id,
        :language_id,
        :owner_id
      ])
      |> foreign_key_constraint(:category_id)
      |> foreign_key_constraint(:language_id)
      |> foreign_key_constraint(:owner_id)
    end
    ```

## Passo 5: Implementando Dropdowns no Formulário

Para transformar um campo de ID em um dropdown com nomes:

1.  Abra o arquivo `form_component.ex` do módulo (ex: `lib/deeper_hub_web/live/server_live/form_component.ex`).
2.  **Carregue os dados na função `update/2`**: Busque as listas das tabelas relacionadas e as atribua ao socket.

    ```elixir
    # Adicione os aliases necessários no topo do arquivo
    alias DeeperHub.Accounts
    alias DeeperHub.Hub

    def update(%{server: server} = assigns, socket) do
      changeset = Hub.change_server(server)

      {:ok,
       socket
       |> assign(assigns)
       |> assign_new(:form, fn -> to_form(changeset) end)
       # Carrega os dados e formata para o dropdown [ {Label, Value}, ... ]
       |> assign_new(:categories, fn -> Hub.list_categories() |> Enum.map(&{&1.name, &1.id}) end)
       |> assign_new(:languages, fn -> Hub.list_languages() |> Enum.map(&{&1.name, &1.id}) end)
       |> assign_new(:users, fn -> Accounts.list_users() |> Enum.map(&{&1.email, &1.id}) end)
      }
    end
    ```

3.  **Renderize o dropdown no template (função `render/1`)**: Substitua o `<.input>` de texto pelo tipo `select`.

    ```elixir
    # Dentro do ~H"""..."""
    <.input field={@form[:category_id]} type="select" label="Category" options={@categories} />
    <.input field={@form[:language_id]} type="select" label="Language" options={@languages} />
    <.input field={@form[:owner_id]} type="select" label="Owner" options={@users} />
    ```

## Passo 6: Estendendo Contextos (Se Necessário)

O contexto `Accounts` não possui uma função `list_users()` por padrão. Se precisar de uma função para listar todos os registros de um contexto, adicione-a.

1.  Abra o arquivo de contexto (ex: `lib/deeper_hub/accounts.ex`).
2.  Adicione a função pública.

    ```elixir
    defmodule DeeperHub.Accounts do
      # ...
      alias DeeperHub.Repo
      alias DeeperHub.Accounts.User

      @doc "Lists all users."
      def list_users do
        Repo.all(User)
      end

      # ... resto do arquivo
    end
    ```

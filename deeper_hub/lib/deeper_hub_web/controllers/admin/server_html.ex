defmodule DeeperHubWeb.Admin.ServerHTML do
  use DeeperHubWeb, :html

  embed_templates "server/*"

  def render("index.html", %{servers: servers} = assigns) do
    ~H"""
    <div class="px-4 sm:px-6 lg:px-8">
      <div class="sm:flex sm:items-center">
        <div class="sm:flex-auto">
          <h1 class="text-2xl font-bold">Servidores</h1>
        </div>
        <div class="mt-4 sm:ml-16 sm:mt-0 sm:flex-none">
          <a href={~p"/admin/servers/new"} class="block rounded-md bg-blue-600 px-3 py-2 text-center text-sm font-semibold text-white shadow-sm hover:bg-blue-500">
            Novo Servidor
          </a>
        </div>
      </div>
      
      <div class="mt-8 flow-root">
        <div class="-mx-4 -my-2 overflow-x-auto sm:-mx-6 lg:-mx-8">
          <div class="inline-block min-w-full py-2 align-middle sm:px-6 lg:px-8">
            <table class="min-w-full divide-y divide-gray-300">
              <thead>
                <tr>
                  <th scope="col" class="py-3.5 pl-4 pr-3 text-left text-sm font-semibold text-gray-900">ID</th>
                  <th scope="col" class="px-3 py-3.5 text-left text-sm font-semibold text-gray-900">Versão</th>
                  <th scope="col" class="px-3 py-3.5 text-left text-sm font-semibold text-gray-900">Encriptação</th>
                  <th scope="col" class="px-3 py-3.5 text-left text-sm font-semibold text-gray-900">Ações</th>
                </tr>
              </thead>
              <tbody class="divide-y divide-gray-200 bg-white">
                <%= for server <- servers do %>
                  <tr>
                    <td class="whitespace-nowrap py-4 pl-4 pr-3 text-sm font-medium text-gray-900"><%= server.id %></td>
                    <td class="whitespace-nowrap px-3 py-4 text-sm text-gray-500"><%= server.platform_version %></td>
                    <td class="whitespace-nowrap px-3 py-4 text-sm text-gray-500"><%= server.encryption_level || "Nenhum" %></td>
                    <td class="whitespace-nowrap px-3 py-4 text-sm text-gray-500 flex gap-2">
                      <a href={~p"/admin/servers/#{server}"} class="text-blue-600 hover:text-blue-900">Ver</a>
                      <a href={~p"/admin/servers/#{server}/edit"} class="text-yellow-600 hover:text-yellow-900">Editar</a>
                      <.link 
                        href={~p"/admin/servers/#{server}"}
                        method="delete"
                        data-confirm="Tem certeza?"
                        class="text-red-600 hover:text-red-900">
                        Excluir
                      </.link>
                    </td>
                  </tr>
                <% end %>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
    """
  end

  def render("new.html", assigns) do
    ~H"""
    <div class="max-w-3xl mx-auto px-4 py-8">
      <h1 class="text-2xl font-bold mb-6">Novo Servidor</h1>

      <.form :let={f} for={@changeset} action={~p"/admin/servers"}>
        <div class="space-y-4">
          <!-- Imagens -->
          <.input field={f[:picture_box]} type="text" label="URL da Imagem Principal" />
          <.input field={f[:picture_icon]} type="text" label="URL do Ícone" />
          <.input field={f[:picture_featured]} type="text" label="URL da Imagem Destaque" />
          <.input field={f[:picture_mini]} type="text" label="URL da Imagem Mini" />
          <.input field={f[:screenshoots]} type="text" label="URLs das Screenshots (separadas por vírgula)" />
          
          <!-- Configurações -->
          <.input field={f[:feature_colors]} type="text" label="Cores de Destaque" />
          <.input field={f[:network_id]} type="number" label="ID da Rede" />
          <.input field={f[:engine_id]} type="number" label="ID do Motor" />
          <.input field={f[:platform_version]} type="text" label="Versão da Plataforma" />
          
          <!-- Opções -->
          <.input field={f[:allow_anonymous]} type="checkbox" label="Permitir Acesso Anônimo?" />
          <.input field={f[:max_connections]} type="number" label="Máximo de Conexões" />
          
          <!-- Dropdown para encryption_level -->
          <div class="form-group">
            <.label for="encryption_level">Nível de Encriptação</.label>
            <select id="encryption_level" name="server[encryption_level]" class="form-control">
              <option value="Nenhum">Nenhum</option>
              <option value="Básico">Básico</option>
              <option value="Avançado">Avançado</option>
              <option value="Máximo">Máximo</option>
            </select>
          </div>
          
          <div class="mt-6">
            <button type="submit" class="bg-blue-500 hover:bg-blue-600 text-white px-4 py-2 rounded">
              Salvar Servidor
            </button>
          </div>
        </div>
      </.form>
    </div>
    """
  end

  def render("show.html", %{server: server} = assigns) do
    ~H"""
    <div class="max-w-4xl mx-auto p-6">
      <h1 class="text-2xl font-bold mb-6">Detalhes do Servidor</h1>
      
      <div class="bg-white shadow rounded-lg p-6">
        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
          <div>
            <h2 class="text-lg font-semibold mb-2">Informações Básicas</h2>
            <p><span class="font-medium">ID:</span> <%= server.id %></p>
            <p><span class="font-medium">Versão da Plataforma:</span> <%= server.platform_version %></p>
            <p><span class="font-medium">Nível de Encriptação:</span> <%= server.encryption_level || "Nenhum" %></p>
          </div>
          
          <div>
            <h2 class="text-lg font-semibold mb-2">Configurações</h2>
            <p><span class="font-medium">Conexões Máximas:</span> <%= server.max_connections %></p>
            <p><span class="font-medium">Anônimo Permitido:</span> <%= if server.allow_anonymous, do: "Sim", else: "Não" %></p>
          </div>
        </div>
        
        <div class="mt-6 flex gap-4">
          <a href={~p"/admin/servers"} class="bg-blue-500 hover:bg-blue-600 text-white px-4 py-2 rounded">
            Voltar para lista
          </a>
          <a href={~p"/admin/servers/#{server}/edit"} class="bg-yellow-500 hover:bg-yellow-600 text-white px-4 py-2 rounded">
            Editar
          </a>
          <.link 
            href={~p"/admin/servers/#{server}"}
            method="delete"
            data-confirm="Tem certeza que deseja excluir este servidor?"
            class="bg-red-500 hover:bg-red-600 text-white px-4 py-2 rounded">
            Excluir
          </.link>
        </div>
      </div>
    </div>
    """
  end

  def render("edit.html", %{server: server, changeset: changeset} = assigns) do
    ~H"""
    <div class="max-w-4xl mx-auto p-6">
      <h1 class="text-2xl font-bold mb-6">Editar Servidor</h1>
      
      <.form :let={f} for={changeset} action={~p"/admin/servers/#{server}"} class="space-y-6">
        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
          <!-- Seção de Imagens -->
          <div class="space-y-4">
            <h2 class="text-lg font-semibold">Imagens</h2>
            <.input field={f[:picture_box]} type="text" label="Picture Box" />
            <.input field={f[:picture_icon]} type="text" label="Picture Icon" />
            <.input field={f[:picture_featured]} type="text" label="Picture Featured" />
            <.input field={f[:picture_mini]} type="text" label="Picture Mini" />
            <.input field={f[:screenshoots]} type="textarea" label="Screenshots" />
          </div>
          
          <!-- Seção de Configurações -->
          <div class="space-y-4">
            <h2 class="text-lg font-semibold">Configurações</h2>
            <.input field={f[:platform_version]} type="text" label="Versão da Plataforma" />
            <.input field={f[:encryption_level]} type="select" label="Nível de Encriptação" options={["Nenhum", "Básico", "Avançado", "Máximo"]} />
            <.input field={f[:network_id]} type="number" label="Network ID" />
            <.input field={f[:engine_id]} type="number" label="Engine ID" />
            <.input field={f[:feature_colors]} type="text" label="Feature Colors" />
          </div>
        </div>
        
        <!-- Seção de Opções -->
        <div class="space-y-4 pt-4">
          <h2 class="text-lg font-semibold">Opções</h2>
          <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
            <.input field={f[:max_connections]} type="number" label="Conexões Máximas" />
            <.input field={f[:allow_anonymous]} type="checkbox" label="Permitir Acesso Anônimo" />
          </div>
        </div>
        
        <div class="flex gap-4 pt-6">
          <button type="submit" class="bg-blue-500 hover:bg-blue-600 text-white px-4 py-2 rounded">
            Salvar Alterações
          </button>
          <a href={~p"/admin/servers/#{server}"} class="bg-gray-500 hover:bg-gray-600 text-white px-4 py-2 rounded">
            Cancelar
          </a>
        </div>
      </.form>
    </div>
    """
  end
end

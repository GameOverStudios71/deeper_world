defmodule DeeperHubWeb.Admin.DashboardHTML do
  use DeeperHubWeb, :html

  embed_templates "dashboard/*"

  def render("index.html", assigns) do
    ~H"""
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
      <h1 class="text-2xl font-bold mb-6">Dashboard Administrativo</h1>
      
      <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
        <div class="bg-white p-6 rounded-lg shadow">
          <h2 class="text-xl font-semibold mb-4">Servidores</h2>
          <.link href={~p"/admin/servers/new"} class="btn btn-primary">
            Criar Novo Servidor
          </.link>
        </div>
      </div>
    </div>
    """
  end
end

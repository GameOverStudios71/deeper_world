defmodule DeeperHubWeb.Admin.ServerController do
  use DeeperHubWeb, :controller

  alias DeeperHub.Servers
  alias DeeperHub.Servers.Server

  def index(conn, _params) do
    servers = Servers.list_servers()
    render(conn, :index, servers: servers)
  end

  def new(conn, _params) do
    changeset = Servers.change_server(%Server{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"server" => server_params}) do
    case Servers.create_server(server_params) do
      {:ok, _server} ->
        conn
        |> put_flash(:info, "Servidor criado com sucesso")
        |> redirect(to: ~p"/admin/servers")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    server = Servers.get_server!(id)
    render(conn, :show, server: server)
  end

  def edit(conn, %{"id" => id}) do
    server = Servers.get_server!(id)
    changeset = Servers.change_server(server)
    render(conn, :edit, server: server, changeset: changeset)
  end

  def update(conn, %{"id" => id, "server" => server_params}) do
    server = Servers.get_server!(id)

    case Servers.update_server(server, server_params) do
      {:ok, server} ->
        conn
        |> put_flash(:info, "Servidor atualizado com sucesso.")
        |> redirect(to: ~p"/admin/servers/#{server}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, server: server, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    server = Servers.get_server!(id)
    {:ok, _server} = Servers.delete_server(server)

    conn
    |> put_flash(:info, "Servidor excluído com sucesso.")
    |> redirect(to: ~p"/admin/servers")
  end
end

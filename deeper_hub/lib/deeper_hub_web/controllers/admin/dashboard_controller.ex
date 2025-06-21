defmodule DeeperHubWeb.Admin.DashboardController do
  use DeeperHubWeb, :controller

  def index(conn, _params) do
    render(conn, :index)
  end
end

defmodule DeeperHubWeb.AdminFlowTest do
  use DeeperHubWeb.ConnCase, async: true

  setup do
    %{user: insert(:user, is_admin: true)}
  end

  test "acesso ao dashboard administrativo", %{conn: conn, user: user} do
    conn =
      conn
      |> log_in_user(user)
      |> get(~p"/admin/dashboard")

    assert html_response(conn, 200) =~ "Dashboard Administrativo"
  end

  test "criação de novo servidor", %{conn: conn, user: user} do
    conn =
      conn
      |> log_in_user(user)
      |> post(~p"/admin/servers", %{
        "server" => %{
          "name" => "Meu Servidor",
          "platform_version" => "1.0",
          "picture_icon" => "icon.png"
        }
      })

    assert redirected_to(conn) == ~p"/admin/servers"
  end
end

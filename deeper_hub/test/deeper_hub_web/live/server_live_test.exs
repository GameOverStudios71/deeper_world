defmodule DeeperHubWeb.ServerLiveTest do
  use DeeperHubWeb.ConnCase

  import Phoenix.LiveViewTest
  import DeeperHub.HubFixtures

  @create_attrs %{server_name: "some server_name", url: "some url", verified: true, latitude: 120.5, longitude: 120.5, country: "some country", region: "some region", city: "some city", description_hero: "some description_hero", description_full: "some description_full", ping_ms: 42, visited_users_lst_mounth: 42, reputation: 42, ai_permission: true, ai_generated: true, server_rules: "some server_rules", server_cpu_info: "some server_cpu_info", server_max_users: 42, min_age: 42, picture_box: "some picture_box", picture_icon: "some picture_icon", picture_featured: "some picture_featured", picture_mini: "some picture_mini", screenshoots: "some screenshoots", feature_colors: "some feature_colors", platform_version: "some platform_version", allow_anonymous: true, max_connections: 42, encryption_level: "some encryption_level"}
  @update_attrs %{server_name: "some updated server_name", url: "some updated url", verified: false, latitude: 456.7, longitude: 456.7, country: "some updated country", region: "some updated region", city: "some updated city", description_hero: "some updated description_hero", description_full: "some updated description_full", ping_ms: 43, visited_users_lst_mounth: 43, reputation: 43, ai_permission: false, ai_generated: false, server_rules: "some updated server_rules", server_cpu_info: "some updated server_cpu_info", server_max_users: 43, min_age: 43, picture_box: "some updated picture_box", picture_icon: "some updated picture_icon", picture_featured: "some updated picture_featured", picture_mini: "some updated picture_mini", screenshoots: "some updated screenshoots", feature_colors: "some updated feature_colors", platform_version: "some updated platform_version", allow_anonymous: false, max_connections: 43, encryption_level: "some updated encryption_level"}
  @invalid_attrs %{server_name: nil, url: nil, verified: false, latitude: nil, longitude: nil, country: nil, region: nil, city: nil, description_hero: nil, description_full: nil, ping_ms: nil, visited_users_lst_mounth: nil, reputation: nil, ai_permission: false, ai_generated: false, server_rules: nil, server_cpu_info: nil, server_max_users: nil, min_age: nil, picture_box: nil, picture_icon: nil, picture_featured: nil, picture_mini: nil, screenshoots: nil, feature_colors: nil, platform_version: nil, allow_anonymous: false, max_connections: nil, encryption_level: nil}

  defp create_server(_) do
    server = server_fixture()
    %{server: server}
  end

  describe "Index" do
    setup [:create_server]

    test "lists all servers", %{conn: conn, server: server} do
      {:ok, _index_live, html} = live(conn, ~p"/servers")

      assert html =~ "Listing Servers"
      assert html =~ server.server_name
    end

    test "saves new server", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/servers")

      assert index_live |> element("a", "New Server") |> render_click() =~
               "New Server"

      assert_patch(index_live, ~p"/servers/new")

      assert index_live
             |> form("#server-form", server: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#server-form", server: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/servers")

      html = render(index_live)
      assert html =~ "Server created successfully"
      assert html =~ "some server_name"
    end

    test "updates server in listing", %{conn: conn, server: server} do
      {:ok, index_live, _html} = live(conn, ~p"/servers")

      assert index_live |> element("#servers-#{server.id} a", "Edit") |> render_click() =~
               "Edit Server"

      assert_patch(index_live, ~p"/servers/#{server}/edit")

      assert index_live
             |> form("#server-form", server: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#server-form", server: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/servers")

      html = render(index_live)
      assert html =~ "Server updated successfully"
      assert html =~ "some updated server_name"
    end

    test "deletes server in listing", %{conn: conn, server: server} do
      {:ok, index_live, _html} = live(conn, ~p"/servers")

      assert index_live |> element("#servers-#{server.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#servers-#{server.id}")
    end
  end

  describe "Show" do
    setup [:create_server]

    test "displays server", %{conn: conn, server: server} do
      {:ok, _show_live, html} = live(conn, ~p"/servers/#{server}")

      assert html =~ "Show Server"
      assert html =~ server.server_name
    end

    test "updates server within modal", %{conn: conn, server: server} do
      {:ok, show_live, _html} = live(conn, ~p"/servers/#{server}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Server"

      assert_patch(show_live, ~p"/servers/#{server}/show/edit")

      assert show_live
             |> form("#server-form", server: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#server-form", server: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/servers/#{server}")

      html = render(show_live)
      assert html =~ "Server updated successfully"
      assert html =~ "some updated server_name"
    end
  end
end

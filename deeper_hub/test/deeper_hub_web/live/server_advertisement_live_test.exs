defmodule DeeperHubWeb.ServerAdvertisementLiveTest do
  use DeeperHubWeb.ConnCase

  import Phoenix.LiveViewTest
  import DeeperHub.HubFixtures

  @create_attrs %{ad_title: "some ad_title", ad_description: "some ad_description", start_date: "2025-06-20T18:00:00Z", end_date: "2025-06-20T18:00:00Z"}
  @update_attrs %{ad_title: "some updated ad_title", ad_description: "some updated ad_description", start_date: "2025-06-21T18:00:00Z", end_date: "2025-06-21T18:00:00Z"}
  @invalid_attrs %{ad_title: nil, ad_description: nil, start_date: nil, end_date: nil}

  defp create_server_advertisement(_) do
    server_advertisement = server_advertisement_fixture()
    %{server_advertisement: server_advertisement}
  end

  describe "Index" do
    setup [:create_server_advertisement]

    test "lists all advertisements", %{conn: conn, server_advertisement: server_advertisement} do
      {:ok, _index_live, html} = live(conn, ~p"/advertisements")

      assert html =~ "Listing Advertisements"
      assert html =~ server_advertisement.ad_title
    end

    test "saves new server_advertisement", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/advertisements")

      assert index_live |> element("a", "New Server advertisement") |> render_click() =~
               "New Server advertisement"

      assert_patch(index_live, ~p"/advertisements/new")

      assert index_live
             |> form("#server_advertisement-form", server_advertisement: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#server_advertisement-form", server_advertisement: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/advertisements")

      html = render(index_live)
      assert html =~ "Server advertisement created successfully"
      assert html =~ "some ad_title"
    end

    test "updates server_advertisement in listing", %{conn: conn, server_advertisement: server_advertisement} do
      {:ok, index_live, _html} = live(conn, ~p"/advertisements")

      assert index_live |> element("#advertisements-#{server_advertisement.id} a", "Edit") |> render_click() =~
               "Edit Server advertisement"

      assert_patch(index_live, ~p"/advertisements/#{server_advertisement}/edit")

      assert index_live
             |> form("#server_advertisement-form", server_advertisement: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#server_advertisement-form", server_advertisement: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/advertisements")

      html = render(index_live)
      assert html =~ "Server advertisement updated successfully"
      assert html =~ "some updated ad_title"
    end

    test "deletes server_advertisement in listing", %{conn: conn, server_advertisement: server_advertisement} do
      {:ok, index_live, _html} = live(conn, ~p"/advertisements")

      assert index_live |> element("#advertisements-#{server_advertisement.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#advertisements-#{server_advertisement.id}")
    end
  end

  describe "Show" do
    setup [:create_server_advertisement]

    test "displays server_advertisement", %{conn: conn, server_advertisement: server_advertisement} do
      {:ok, _show_live, html} = live(conn, ~p"/advertisements/#{server_advertisement}")

      assert html =~ "Show Server advertisement"
      assert html =~ server_advertisement.ad_title
    end

    test "updates server_advertisement within modal", %{conn: conn, server_advertisement: server_advertisement} do
      {:ok, show_live, _html} = live(conn, ~p"/advertisements/#{server_advertisement}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Server advertisement"

      assert_patch(show_live, ~p"/advertisements/#{server_advertisement}/show/edit")

      assert show_live
             |> form("#server_advertisement-form", server_advertisement: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#server_advertisement-form", server_advertisement: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/advertisements/#{server_advertisement}")

      html = render(show_live)
      assert html =~ "Server advertisement updated successfully"
      assert html =~ "some updated ad_title"
    end
  end
end

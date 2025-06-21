defmodule DeeperHubWeb.ServerReputationLiveTest do
  use DeeperHubWeb.ConnCase

  import Phoenix.LiveViewTest
  import DeeperHub.HubFixtures

  @create_attrs %{reputation_score: 42, last_updated: "2025-06-20T18:00:00Z"}
  @update_attrs %{reputation_score: 43, last_updated: "2025-06-21T18:00:00Z"}
  @invalid_attrs %{reputation_score: nil, last_updated: nil}

  defp create_server_reputation(_) do
    server_reputation = server_reputation_fixture()
    %{server_reputation: server_reputation}
  end

  describe "Index" do
    setup [:create_server_reputation]

    test "lists all server_reputation", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/server_reputation")

      assert html =~ "Listing Server reputation"
    end

    test "saves new server_reputation", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/server_reputation")

      assert index_live |> element("a", "New Server reputation") |> render_click() =~
               "New Server reputation"

      assert_patch(index_live, ~p"/server_reputation/new")

      assert index_live
             |> form("#server_reputation-form", server_reputation: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#server_reputation-form", server_reputation: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/server_reputation")

      html = render(index_live)
      assert html =~ "Server reputation created successfully"
    end

    test "updates server_reputation in listing", %{conn: conn, server_reputation: server_reputation} do
      {:ok, index_live, _html} = live(conn, ~p"/server_reputation")

      assert index_live |> element("#server_reputation-#{server_reputation.id} a", "Edit") |> render_click() =~
               "Edit Server reputation"

      assert_patch(index_live, ~p"/server_reputation/#{server_reputation}/edit")

      assert index_live
             |> form("#server_reputation-form", server_reputation: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#server_reputation-form", server_reputation: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/server_reputation")

      html = render(index_live)
      assert html =~ "Server reputation updated successfully"
    end

    test "deletes server_reputation in listing", %{conn: conn, server_reputation: server_reputation} do
      {:ok, index_live, _html} = live(conn, ~p"/server_reputation")

      assert index_live |> element("#server_reputation-#{server_reputation.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#server_reputation-#{server_reputation.id}")
    end
  end

  describe "Show" do
    setup [:create_server_reputation]

    test "displays server_reputation", %{conn: conn, server_reputation: server_reputation} do
      {:ok, _show_live, html} = live(conn, ~p"/server_reputation/#{server_reputation}")

      assert html =~ "Show Server reputation"
    end

    test "updates server_reputation within modal", %{conn: conn, server_reputation: server_reputation} do
      {:ok, show_live, _html} = live(conn, ~p"/server_reputation/#{server_reputation}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Server reputation"

      assert_patch(show_live, ~p"/server_reputation/#{server_reputation}/show/edit")

      assert show_live
             |> form("#server_reputation-form", server_reputation: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#server_reputation-form", server_reputation: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/server_reputation/#{server_reputation}")

      html = render(show_live)
      assert html =~ "Server reputation updated successfully"
    end
  end
end

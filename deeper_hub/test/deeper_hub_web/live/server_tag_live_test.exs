defmodule DeeperHubWeb.ServerTagLiveTest do
  use DeeperHubWeb.ConnCase

  import Phoenix.LiveViewTest
  import DeeperHub.HubFixtures

  @create_attrs %{tag: "some tag"}
  @update_attrs %{tag: "some updated tag"}
  @invalid_attrs %{tag: nil}

  defp create_server_tag(_) do
    server_tag = server_tag_fixture()
    %{server_tag: server_tag}
  end

  describe "Index" do
    setup [:create_server_tag]

    test "lists all server_tags", %{conn: conn, server_tag: server_tag} do
      {:ok, _index_live, html} = live(conn, ~p"/server_tags")

      assert html =~ "Listing Server tags"
      assert html =~ server_tag.tag
    end

    test "saves new server_tag", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/server_tags")

      assert index_live |> element("a", "New Server tag") |> render_click() =~
               "New Server tag"

      assert_patch(index_live, ~p"/server_tags/new")

      assert index_live
             |> form("#server_tag-form", server_tag: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#server_tag-form", server_tag: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/server_tags")

      html = render(index_live)
      assert html =~ "Server tag created successfully"
      assert html =~ "some tag"
    end

    test "updates server_tag in listing", %{conn: conn, server_tag: server_tag} do
      {:ok, index_live, _html} = live(conn, ~p"/server_tags")

      assert index_live |> element("#server_tags-#{server_tag.id} a", "Edit") |> render_click() =~
               "Edit Server tag"

      assert_patch(index_live, ~p"/server_tags/#{server_tag}/edit")

      assert index_live
             |> form("#server_tag-form", server_tag: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#server_tag-form", server_tag: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/server_tags")

      html = render(index_live)
      assert html =~ "Server tag updated successfully"
      assert html =~ "some updated tag"
    end

    test "deletes server_tag in listing", %{conn: conn, server_tag: server_tag} do
      {:ok, index_live, _html} = live(conn, ~p"/server_tags")

      assert index_live |> element("#server_tags-#{server_tag.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#server_tags-#{server_tag.id}")
    end
  end

  describe "Show" do
    setup [:create_server_tag]

    test "displays server_tag", %{conn: conn, server_tag: server_tag} do
      {:ok, _show_live, html} = live(conn, ~p"/server_tags/#{server_tag}")

      assert html =~ "Show Server tag"
      assert html =~ server_tag.tag
    end

    test "updates server_tag within modal", %{conn: conn, server_tag: server_tag} do
      {:ok, show_live, _html} = live(conn, ~p"/server_tags/#{server_tag}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Server tag"

      assert_patch(show_live, ~p"/server_tags/#{server_tag}/show/edit")

      assert show_live
             |> form("#server_tag-form", server_tag: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#server_tag-form", server_tag: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/server_tags/#{server_tag}")

      html = render(show_live)
      assert html =~ "Server tag updated successfully"
      assert html =~ "some updated tag"
    end
  end
end

defmodule DeeperHubWeb.ContentTypeLiveTest do
  use DeeperHubWeb.ConnCase

  import Phoenix.LiveViewTest
  import DeeperHub.HubFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp create_content_type(_) do
    content_type = content_type_fixture()
    %{content_type: content_type}
  end

  describe "Index" do
    setup [:create_content_type]

    test "lists all content_types", %{conn: conn, content_type: content_type} do
      {:ok, _index_live, html} = live(conn, ~p"/content_types")

      assert html =~ "Listing Content types"
      assert html =~ content_type.name
    end

    test "saves new content_type", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/content_types")

      assert index_live |> element("a", "New Content type") |> render_click() =~
               "New Content type"

      assert_patch(index_live, ~p"/content_types/new")

      assert index_live
             |> form("#content_type-form", content_type: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#content_type-form", content_type: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/content_types")

      html = render(index_live)
      assert html =~ "Content type created successfully"
      assert html =~ "some name"
    end

    test "updates content_type in listing", %{conn: conn, content_type: content_type} do
      {:ok, index_live, _html} = live(conn, ~p"/content_types")

      assert index_live |> element("#content_types-#{content_type.id} a", "Edit") |> render_click() =~
               "Edit Content type"

      assert_patch(index_live, ~p"/content_types/#{content_type}/edit")

      assert index_live
             |> form("#content_type-form", content_type: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#content_type-form", content_type: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/content_types")

      html = render(index_live)
      assert html =~ "Content type updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes content_type in listing", %{conn: conn, content_type: content_type} do
      {:ok, index_live, _html} = live(conn, ~p"/content_types")

      assert index_live |> element("#content_types-#{content_type.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#content_types-#{content_type.id}")
    end
  end

  describe "Show" do
    setup [:create_content_type]

    test "displays content_type", %{conn: conn, content_type: content_type} do
      {:ok, _show_live, html} = live(conn, ~p"/content_types/#{content_type}")

      assert html =~ "Show Content type"
      assert html =~ content_type.name
    end

    test "updates content_type within modal", %{conn: conn, content_type: content_type} do
      {:ok, show_live, _html} = live(conn, ~p"/content_types/#{content_type}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Content type"

      assert_patch(show_live, ~p"/content_types/#{content_type}/show/edit")

      assert show_live
             |> form("#content_type-form", content_type: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#content_type-form", content_type: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/content_types/#{content_type}")

      html = render(show_live)
      assert html =~ "Content type updated successfully"
      assert html =~ "some updated name"
    end
  end
end

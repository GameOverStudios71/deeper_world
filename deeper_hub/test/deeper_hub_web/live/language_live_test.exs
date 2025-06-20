defmodule DeeperHubWeb.LanguageLiveTest do
  use DeeperHubWeb.ConnCase

  import Phoenix.LiveViewTest
  import DeeperHub.HubFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp create_language(_) do
    language = language_fixture()
    %{language: language}
  end

  describe "Index" do
    setup [:create_language]

    test "lists all languages", %{conn: conn, language: language} do
      {:ok, _index_live, html} = live(conn, ~p"/languages")

      assert html =~ "Listing Languages"
      assert html =~ language.name
    end

    test "saves new language", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/languages")

      assert index_live |> element("a", "New Language") |> render_click() =~
               "New Language"

      assert_patch(index_live, ~p"/languages/new")

      assert index_live
             |> form("#language-form", language: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#language-form", language: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/languages")

      html = render(index_live)
      assert html =~ "Language created successfully"
      assert html =~ "some name"
    end

    test "updates language in listing", %{conn: conn, language: language} do
      {:ok, index_live, _html} = live(conn, ~p"/languages")

      assert index_live |> element("#languages-#{language.id} a", "Edit") |> render_click() =~
               "Edit Language"

      assert_patch(index_live, ~p"/languages/#{language}/edit")

      assert index_live
             |> form("#language-form", language: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#language-form", language: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/languages")

      html = render(index_live)
      assert html =~ "Language updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes language in listing", %{conn: conn, language: language} do
      {:ok, index_live, _html} = live(conn, ~p"/languages")

      assert index_live |> element("#languages-#{language.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#languages-#{language.id}")
    end
  end

  describe "Show" do
    setup [:create_language]

    test "displays language", %{conn: conn, language: language} do
      {:ok, _show_live, html} = live(conn, ~p"/languages/#{language}")

      assert html =~ "Show Language"
      assert html =~ language.name
    end

    test "updates language within modal", %{conn: conn, language: language} do
      {:ok, show_live, _html} = live(conn, ~p"/languages/#{language}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Language"

      assert_patch(show_live, ~p"/languages/#{language}/show/edit")

      assert show_live
             |> form("#language-form", language: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#language-form", language: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/languages/#{language}")

      html = render(show_live)
      assert html =~ "Language updated successfully"
      assert html =~ "some updated name"
    end
  end
end

defmodule DeeperHubWeb.AchievementTypeLiveTest do
  use DeeperHubWeb.ConnCase

  import Phoenix.LiveViewTest
  import DeeperHub.HubFixtures

  @create_attrs %{name: "some name", description: "some description"}
  @update_attrs %{name: "some updated name", description: "some updated description"}
  @invalid_attrs %{name: nil, description: nil}

  defp create_achievement_type(_) do
    achievement_type = achievement_type_fixture()
    %{achievement_type: achievement_type}
  end

  describe "Index" do
    setup [:create_achievement_type]

    test "lists all achievement_types", %{conn: conn, achievement_type: achievement_type} do
      {:ok, _index_live, html} = live(conn, ~p"/achievement_types")

      assert html =~ "Listing Achievement types"
      assert html =~ achievement_type.name
    end

    test "saves new achievement_type", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/achievement_types")

      assert index_live |> element("a", "New Achievement type") |> render_click() =~
               "New Achievement type"

      assert_patch(index_live, ~p"/achievement_types/new")

      assert index_live
             |> form("#achievement_type-form", achievement_type: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#achievement_type-form", achievement_type: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/achievement_types")

      html = render(index_live)
      assert html =~ "Achievement type created successfully"
      assert html =~ "some name"
    end

    test "updates achievement_type in listing", %{conn: conn, achievement_type: achievement_type} do
      {:ok, index_live, _html} = live(conn, ~p"/achievement_types")

      assert index_live |> element("#achievement_types-#{achievement_type.id} a", "Edit") |> render_click() =~
               "Edit Achievement type"

      assert_patch(index_live, ~p"/achievement_types/#{achievement_type}/edit")

      assert index_live
             |> form("#achievement_type-form", achievement_type: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#achievement_type-form", achievement_type: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/achievement_types")

      html = render(index_live)
      assert html =~ "Achievement type updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes achievement_type in listing", %{conn: conn, achievement_type: achievement_type} do
      {:ok, index_live, _html} = live(conn, ~p"/achievement_types")

      assert index_live |> element("#achievement_types-#{achievement_type.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#achievement_types-#{achievement_type.id}")
    end
  end

  describe "Show" do
    setup [:create_achievement_type]

    test "displays achievement_type", %{conn: conn, achievement_type: achievement_type} do
      {:ok, _show_live, html} = live(conn, ~p"/achievement_types/#{achievement_type}")

      assert html =~ "Show Achievement type"
      assert html =~ achievement_type.name
    end

    test "updates achievement_type within modal", %{conn: conn, achievement_type: achievement_type} do
      {:ok, show_live, _html} = live(conn, ~p"/achievement_types/#{achievement_type}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Achievement type"

      assert_patch(show_live, ~p"/achievement_types/#{achievement_type}/show/edit")

      assert show_live
             |> form("#achievement_type-form", achievement_type: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#achievement_type-form", achievement_type: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/achievement_types/#{achievement_type}")

      html = render(show_live)
      assert html =~ "Achievement type updated successfully"
      assert html =~ "some updated name"
    end
  end
end

defmodule DeeperHubWeb.FeedbackTypeLiveTest do
  use DeeperHubWeb.ConnCase

  import Phoenix.LiveViewTest
  import DeeperHub.HubFixtures

  @create_attrs %{name: "some name", description: "some description"}
  @update_attrs %{name: "some updated name", description: "some updated description"}
  @invalid_attrs %{name: nil, description: nil}

  defp create_feedback_type(_) do
    feedback_type = feedback_type_fixture()
    %{feedback_type: feedback_type}
  end

  describe "Index" do
    setup [:create_feedback_type]

    test "lists all feedback_types", %{conn: conn, feedback_type: feedback_type} do
      {:ok, _index_live, html} = live(conn, ~p"/feedback_types")

      assert html =~ "Listing Feedback types"
      assert html =~ feedback_type.name
    end

    test "saves new feedback_type", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/feedback_types")

      assert index_live |> element("a", "New Feedback type") |> render_click() =~
               "New Feedback type"

      assert_patch(index_live, ~p"/feedback_types/new")

      assert index_live
             |> form("#feedback_type-form", feedback_type: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#feedback_type-form", feedback_type: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/feedback_types")

      html = render(index_live)
      assert html =~ "Feedback type created successfully"
      assert html =~ "some name"
    end

    test "updates feedback_type in listing", %{conn: conn, feedback_type: feedback_type} do
      {:ok, index_live, _html} = live(conn, ~p"/feedback_types")

      assert index_live |> element("#feedback_types-#{feedback_type.id} a", "Edit") |> render_click() =~
               "Edit Feedback type"

      assert_patch(index_live, ~p"/feedback_types/#{feedback_type}/edit")

      assert index_live
             |> form("#feedback_type-form", feedback_type: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#feedback_type-form", feedback_type: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/feedback_types")

      html = render(index_live)
      assert html =~ "Feedback type updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes feedback_type in listing", %{conn: conn, feedback_type: feedback_type} do
      {:ok, index_live, _html} = live(conn, ~p"/feedback_types")

      assert index_live |> element("#feedback_types-#{feedback_type.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#feedback_types-#{feedback_type.id}")
    end
  end

  describe "Show" do
    setup [:create_feedback_type]

    test "displays feedback_type", %{conn: conn, feedback_type: feedback_type} do
      {:ok, _show_live, html} = live(conn, ~p"/feedback_types/#{feedback_type}")

      assert html =~ "Show Feedback type"
      assert html =~ feedback_type.name
    end

    test "updates feedback_type within modal", %{conn: conn, feedback_type: feedback_type} do
      {:ok, show_live, _html} = live(conn, ~p"/feedback_types/#{feedback_type}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Feedback type"

      assert_patch(show_live, ~p"/feedback_types/#{feedback_type}/show/edit")

      assert show_live
             |> form("#feedback_type-form", feedback_type: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#feedback_type-form", feedback_type: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/feedback_types/#{feedback_type}")

      html = render(show_live)
      assert html =~ "Feedback type updated successfully"
      assert html =~ "some updated name"
    end
  end
end

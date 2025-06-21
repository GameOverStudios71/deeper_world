defmodule DeeperHubWeb.UserFeedbackLiveTest do
  use DeeperHubWeb.ConnCase

  import Phoenix.LiveViewTest
  import DeeperHub.HubFixtures

  @create_attrs %{feedback_text: "some feedback_text", submitted_at: "2025-06-20T17:59:00Z"}
  @update_attrs %{feedback_text: "some updated feedback_text", submitted_at: "2025-06-21T17:59:00Z"}
  @invalid_attrs %{feedback_text: nil, submitted_at: nil}

  defp create_user_feedback(_) do
    user_feedback = user_feedback_fixture()
    %{user_feedback: user_feedback}
  end

  describe "Index" do
    setup [:create_user_feedback]

    test "lists all user_feedback", %{conn: conn, user_feedback: user_feedback} do
      {:ok, _index_live, html} = live(conn, ~p"/user_feedback")

      assert html =~ "Listing User feedback"
      assert html =~ user_feedback.feedback_text
    end

    test "saves new user_feedback", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/user_feedback")

      assert index_live |> element("a", "New User feedback") |> render_click() =~
               "New User feedback"

      assert_patch(index_live, ~p"/user_feedback/new")

      assert index_live
             |> form("#user_feedback-form", user_feedback: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#user_feedback-form", user_feedback: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/user_feedback")

      html = render(index_live)
      assert html =~ "User feedback created successfully"
      assert html =~ "some feedback_text"
    end

    test "updates user_feedback in listing", %{conn: conn, user_feedback: user_feedback} do
      {:ok, index_live, _html} = live(conn, ~p"/user_feedback")

      assert index_live |> element("#user_feedback-#{user_feedback.id} a", "Edit") |> render_click() =~
               "Edit User feedback"

      assert_patch(index_live, ~p"/user_feedback/#{user_feedback}/edit")

      assert index_live
             |> form("#user_feedback-form", user_feedback: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#user_feedback-form", user_feedback: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/user_feedback")

      html = render(index_live)
      assert html =~ "User feedback updated successfully"
      assert html =~ "some updated feedback_text"
    end

    test "deletes user_feedback in listing", %{conn: conn, user_feedback: user_feedback} do
      {:ok, index_live, _html} = live(conn, ~p"/user_feedback")

      assert index_live |> element("#user_feedback-#{user_feedback.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#user_feedback-#{user_feedback.id}")
    end
  end

  describe "Show" do
    setup [:create_user_feedback]

    test "displays user_feedback", %{conn: conn, user_feedback: user_feedback} do
      {:ok, _show_live, html} = live(conn, ~p"/user_feedback/#{user_feedback}")

      assert html =~ "Show User feedback"
      assert html =~ user_feedback.feedback_text
    end

    test "updates user_feedback within modal", %{conn: conn, user_feedback: user_feedback} do
      {:ok, show_live, _html} = live(conn, ~p"/user_feedback/#{user_feedback}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit User feedback"

      assert_patch(show_live, ~p"/user_feedback/#{user_feedback}/show/edit")

      assert show_live
             |> form("#user_feedback-form", user_feedback: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#user_feedback-form", user_feedback: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/user_feedback/#{user_feedback}")

      html = render(show_live)
      assert html =~ "User feedback updated successfully"
      assert html =~ "some updated feedback_text"
    end
  end
end

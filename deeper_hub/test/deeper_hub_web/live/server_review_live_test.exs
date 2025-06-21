defmodule DeeperHubWeb.ServerReviewLiveTest do
  use DeeperHubWeb.ConnCase

  import Phoenix.LiveViewTest
  import DeeperHub.HubFixtures

  @create_attrs %{comments: "some comments", rating: 42}
  @update_attrs %{comments: "some updated comments", rating: 43}
  @invalid_attrs %{comments: nil, rating: nil}

  defp create_server_review(_) do
    server_review = server_review_fixture()
    %{server_review: server_review}
  end

  describe "Index" do
    setup [:create_server_review]

    test "lists all reviews", %{conn: conn, server_review: server_review} do
      {:ok, _index_live, html} = live(conn, ~p"/reviews")

      assert html =~ "Listing Reviews"
      assert html =~ server_review.comments
    end

    test "saves new server_review", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/reviews")

      assert index_live |> element("a", "New Server review") |> render_click() =~
               "New Server review"

      assert_patch(index_live, ~p"/reviews/new")

      assert index_live
             |> form("#server_review-form", server_review: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#server_review-form", server_review: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/reviews")

      html = render(index_live)
      assert html =~ "Server review created successfully"
      assert html =~ "some comments"
    end

    test "updates server_review in listing", %{conn: conn, server_review: server_review} do
      {:ok, index_live, _html} = live(conn, ~p"/reviews")

      assert index_live |> element("#reviews-#{server_review.id} a", "Edit") |> render_click() =~
               "Edit Server review"

      assert_patch(index_live, ~p"/reviews/#{server_review}/edit")

      assert index_live
             |> form("#server_review-form", server_review: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#server_review-form", server_review: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/reviews")

      html = render(index_live)
      assert html =~ "Server review updated successfully"
      assert html =~ "some updated comments"
    end

    test "deletes server_review in listing", %{conn: conn, server_review: server_review} do
      {:ok, index_live, _html} = live(conn, ~p"/reviews")

      assert index_live |> element("#reviews-#{server_review.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#reviews-#{server_review.id}")
    end
  end

  describe "Show" do
    setup [:create_server_review]

    test "displays server_review", %{conn: conn, server_review: server_review} do
      {:ok, _show_live, html} = live(conn, ~p"/reviews/#{server_review}")

      assert html =~ "Show Server review"
      assert html =~ server_review.comments
    end

    test "updates server_review within modal", %{conn: conn, server_review: server_review} do
      {:ok, show_live, _html} = live(conn, ~p"/reviews/#{server_review}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Server review"

      assert_patch(show_live, ~p"/reviews/#{server_review}/show/edit")

      assert show_live
             |> form("#server_review-form", server_review: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#server_review-form", server_review: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/reviews/#{server_review}")

      html = render(show_live)
      assert html =~ "Server review updated successfully"
      assert html =~ "some updated comments"
    end
  end
end

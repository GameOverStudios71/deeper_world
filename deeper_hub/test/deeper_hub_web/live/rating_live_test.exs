defmodule DeeperHubWeb.RatingLiveTest do
  use DeeperHubWeb.ConnCase

  import Phoenix.LiveViewTest
  import DeeperHub.HubFixtures

  @create_attrs %{rating: 42}
  @update_attrs %{rating: 43}
  @invalid_attrs %{rating: nil}

  defp create_rating(_) do
    rating = rating_fixture()
    %{rating: rating}
  end

  describe "Index" do
    setup [:create_rating]

    test "lists all ratings", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/ratings")

      assert html =~ "Listing Ratings"
    end

    test "saves new rating", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/ratings")

      assert index_live |> element("a", "New Rating") |> render_click() =~
               "New Rating"

      assert_patch(index_live, ~p"/ratings/new")

      assert index_live
             |> form("#rating-form", rating: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#rating-form", rating: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/ratings")

      html = render(index_live)
      assert html =~ "Rating created successfully"
    end

    test "updates rating in listing", %{conn: conn, rating: rating} do
      {:ok, index_live, _html} = live(conn, ~p"/ratings")

      assert index_live |> element("#ratings-#{rating.id} a", "Edit") |> render_click() =~
               "Edit Rating"

      assert_patch(index_live, ~p"/ratings/#{rating}/edit")

      assert index_live
             |> form("#rating-form", rating: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#rating-form", rating: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/ratings")

      html = render(index_live)
      assert html =~ "Rating updated successfully"
    end

    test "deletes rating in listing", %{conn: conn, rating: rating} do
      {:ok, index_live, _html} = live(conn, ~p"/ratings")

      assert index_live |> element("#ratings-#{rating.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#ratings-#{rating.id}")
    end
  end

  describe "Show" do
    setup [:create_rating]

    test "displays rating", %{conn: conn, rating: rating} do
      {:ok, _show_live, html} = live(conn, ~p"/ratings/#{rating}")

      assert html =~ "Show Rating"
    end

    test "updates rating within modal", %{conn: conn, rating: rating} do
      {:ok, show_live, _html} = live(conn, ~p"/ratings/#{rating}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Rating"

      assert_patch(show_live, ~p"/ratings/#{rating}/show/edit")

      assert show_live
             |> form("#rating-form", rating: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#rating-form", rating: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/ratings/#{rating}")

      html = render(show_live)
      assert html =~ "Rating updated successfully"
    end
  end
end

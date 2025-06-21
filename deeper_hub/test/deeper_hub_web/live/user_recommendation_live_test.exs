defmodule DeeperHubWeb.UserRecommendationLiveTest do
  use DeeperHubWeb.ConnCase

  import Phoenix.LiveViewTest
  import DeeperHub.HubFixtures

  @create_attrs %{recommendation_score: 120.5}
  @update_attrs %{recommendation_score: 456.7}
  @invalid_attrs %{recommendation_score: nil}

  defp create_user_recommendation(_) do
    user_recommendation = user_recommendation_fixture()
    %{user_recommendation: user_recommendation}
  end

  describe "Index" do
    setup [:create_user_recommendation]

    test "lists all user_recommendations", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/user_recommendations")

      assert html =~ "Listing User recommendations"
    end

    test "saves new user_recommendation", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/user_recommendations")

      assert index_live |> element("a", "New User recommendation") |> render_click() =~
               "New User recommendation"

      assert_patch(index_live, ~p"/user_recommendations/new")

      assert index_live
             |> form("#user_recommendation-form", user_recommendation: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#user_recommendation-form", user_recommendation: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/user_recommendations")

      html = render(index_live)
      assert html =~ "User recommendation created successfully"
    end

    test "updates user_recommendation in listing", %{conn: conn, user_recommendation: user_recommendation} do
      {:ok, index_live, _html} = live(conn, ~p"/user_recommendations")

      assert index_live |> element("#user_recommendations-#{user_recommendation.id} a", "Edit") |> render_click() =~
               "Edit User recommendation"

      assert_patch(index_live, ~p"/user_recommendations/#{user_recommendation}/edit")

      assert index_live
             |> form("#user_recommendation-form", user_recommendation: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#user_recommendation-form", user_recommendation: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/user_recommendations")

      html = render(index_live)
      assert html =~ "User recommendation updated successfully"
    end

    test "deletes user_recommendation in listing", %{conn: conn, user_recommendation: user_recommendation} do
      {:ok, index_live, _html} = live(conn, ~p"/user_recommendations")

      assert index_live |> element("#user_recommendations-#{user_recommendation.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#user_recommendations-#{user_recommendation.id}")
    end
  end

  describe "Show" do
    setup [:create_user_recommendation]

    test "displays user_recommendation", %{conn: conn, user_recommendation: user_recommendation} do
      {:ok, _show_live, html} = live(conn, ~p"/user_recommendations/#{user_recommendation}")

      assert html =~ "Show User recommendation"
    end

    test "updates user_recommendation within modal", %{conn: conn, user_recommendation: user_recommendation} do
      {:ok, show_live, _html} = live(conn, ~p"/user_recommendations/#{user_recommendation}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit User recommendation"

      assert_patch(show_live, ~p"/user_recommendations/#{user_recommendation}/show/edit")

      assert show_live
             |> form("#user_recommendation-form", user_recommendation: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#user_recommendation-form", user_recommendation: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/user_recommendations/#{user_recommendation}")

      html = render(show_live)
      assert html =~ "User recommendation updated successfully"
    end
  end
end

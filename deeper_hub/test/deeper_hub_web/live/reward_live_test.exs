defmodule DeeperHubWeb.RewardLiveTest do
  use DeeperHubWeb.ConnCase

  import Phoenix.LiveViewTest
  import DeeperHub.HubFixtures

  @create_attrs %{reward_name: "some reward_name", reward_description: "some reward_description", points_required: 42}
  @update_attrs %{reward_name: "some updated reward_name", reward_description: "some updated reward_description", points_required: 43}
  @invalid_attrs %{reward_name: nil, reward_description: nil, points_required: nil}

  defp create_reward(_) do
    reward = reward_fixture()
    %{reward: reward}
  end

  describe "Index" do
    setup [:create_reward]

    test "lists all rewards", %{conn: conn, reward: reward} do
      {:ok, _index_live, html} = live(conn, ~p"/rewards")

      assert html =~ "Listing Rewards"
      assert html =~ reward.reward_name
    end

    test "saves new reward", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/rewards")

      assert index_live |> element("a", "New Reward") |> render_click() =~
               "New Reward"

      assert_patch(index_live, ~p"/rewards/new")

      assert index_live
             |> form("#reward-form", reward: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#reward-form", reward: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/rewards")

      html = render(index_live)
      assert html =~ "Reward created successfully"
      assert html =~ "some reward_name"
    end

    test "updates reward in listing", %{conn: conn, reward: reward} do
      {:ok, index_live, _html} = live(conn, ~p"/rewards")

      assert index_live |> element("#rewards-#{reward.id} a", "Edit") |> render_click() =~
               "Edit Reward"

      assert_patch(index_live, ~p"/rewards/#{reward}/edit")

      assert index_live
             |> form("#reward-form", reward: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#reward-form", reward: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/rewards")

      html = render(index_live)
      assert html =~ "Reward updated successfully"
      assert html =~ "some updated reward_name"
    end

    test "deletes reward in listing", %{conn: conn, reward: reward} do
      {:ok, index_live, _html} = live(conn, ~p"/rewards")

      assert index_live |> element("#rewards-#{reward.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#rewards-#{reward.id}")
    end
  end

  describe "Show" do
    setup [:create_reward]

    test "displays reward", %{conn: conn, reward: reward} do
      {:ok, _show_live, html} = live(conn, ~p"/rewards/#{reward}")

      assert html =~ "Show Reward"
      assert html =~ reward.reward_name
    end

    test "updates reward within modal", %{conn: conn, reward: reward} do
      {:ok, show_live, _html} = live(conn, ~p"/rewards/#{reward}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Reward"

      assert_patch(show_live, ~p"/rewards/#{reward}/show/edit")

      assert show_live
             |> form("#reward-form", reward: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#reward-form", reward: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/rewards/#{reward}")

      html = render(show_live)
      assert html =~ "Reward updated successfully"
      assert html =~ "some updated reward_name"
    end
  end
end

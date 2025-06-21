defmodule DeeperHubWeb.NetworkLiveTest do
  use DeeperHubWeb.ConnCase

  import Phoenix.LiveViewTest
  import DeeperHub.HubFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp create_network(_) do
    network = network_fixture()
    %{network: network}
  end

  describe "Index" do
    setup [:create_network]

    test "lists all networks", %{conn: conn, network: network} do
      {:ok, _index_live, html} = live(conn, ~p"/networks")

      assert html =~ "Listing Networks"
      assert html =~ network.name
    end

    test "saves new network", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/networks")

      assert index_live |> element("a", "New Network") |> render_click() =~
               "New Network"

      assert_patch(index_live, ~p"/networks/new")

      assert index_live
             |> form("#network-form", network: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#network-form", network: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/networks")

      html = render(index_live)
      assert html =~ "Network created successfully"
      assert html =~ "some name"
    end

    test "updates network in listing", %{conn: conn, network: network} do
      {:ok, index_live, _html} = live(conn, ~p"/networks")

      assert index_live |> element("#networks-#{network.id} a", "Edit") |> render_click() =~
               "Edit Network"

      assert_patch(index_live, ~p"/networks/#{network}/edit")

      assert index_live
             |> form("#network-form", network: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#network-form", network: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/networks")

      html = render(index_live)
      assert html =~ "Network updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes network in listing", %{conn: conn, network: network} do
      {:ok, index_live, _html} = live(conn, ~p"/networks")

      assert index_live |> element("#networks-#{network.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#networks-#{network.id}")
    end
  end

  describe "Show" do
    setup [:create_network]

    test "displays network", %{conn: conn, network: network} do
      {:ok, _show_live, html} = live(conn, ~p"/networks/#{network}")

      assert html =~ "Show Network"
      assert html =~ network.name
    end

    test "updates network within modal", %{conn: conn, network: network} do
      {:ok, show_live, _html} = live(conn, ~p"/networks/#{network}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Network"

      assert_patch(show_live, ~p"/networks/#{network}/show/edit")

      assert show_live
             |> form("#network-form", network: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#network-form", network: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/networks/#{network}")

      html = render(show_live)
      assert html =~ "Network updated successfully"
      assert html =~ "some updated name"
    end
  end
end

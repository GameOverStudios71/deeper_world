defmodule DeeperHubWeb.StatusLiveTest do
  use DeeperHubWeb.ConnCase

  import Phoenix.LiveViewTest
  import DeeperHub.HubFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp create_status(_) do
    status = status_fixture()
    %{status: status}
  end

  describe "Index" do
    setup [:create_status]

    test "lists all statuses", %{conn: conn, status: status} do
      {:ok, _index_live, html} = live(conn, ~p"/statuses")

      assert html =~ "Listing Statuses"
      assert html =~ status.name
    end

    test "saves new status", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/statuses")

      assert index_live |> element("a", "New Status") |> render_click() =~
               "New Status"

      assert_patch(index_live, ~p"/statuses/new")

      assert index_live
             |> form("#status-form", status: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#status-form", status: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/statuses")

      html = render(index_live)
      assert html =~ "Status created successfully"
      assert html =~ "some name"
    end

    test "updates status in listing", %{conn: conn, status: status} do
      {:ok, index_live, _html} = live(conn, ~p"/statuses")

      assert index_live |> element("#statuses-#{status.id} a", "Edit") |> render_click() =~
               "Edit Status"

      assert_patch(index_live, ~p"/statuses/#{status}/edit")

      assert index_live
             |> form("#status-form", status: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#status-form", status: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/statuses")

      html = render(index_live)
      assert html =~ "Status updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes status in listing", %{conn: conn, status: status} do
      {:ok, index_live, _html} = live(conn, ~p"/statuses")

      assert index_live |> element("#statuses-#{status.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#statuses-#{status.id}")
    end
  end

  describe "Show" do
    setup [:create_status]

    test "displays status", %{conn: conn, status: status} do
      {:ok, _show_live, html} = live(conn, ~p"/statuses/#{status}")

      assert html =~ "Show Status"
      assert html =~ status.name
    end

    test "updates status within modal", %{conn: conn, status: status} do
      {:ok, show_live, _html} = live(conn, ~p"/statuses/#{status}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Status"

      assert_patch(show_live, ~p"/statuses/#{status}/show/edit")

      assert show_live
             |> form("#status-form", status: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#status-form", status: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/statuses/#{status}")

      html = render(show_live)
      assert html =~ "Status updated successfully"
      assert html =~ "some updated name"
    end
  end
end

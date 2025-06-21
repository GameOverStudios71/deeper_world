defmodule DeeperHubWeb.ServerEventLiveTest do
  use DeeperHubWeb.ConnCase

  import Phoenix.LiveViewTest
  import DeeperHub.HubFixtures

  @create_attrs %{description: "some description", title: "some title", start_time: "2025-06-20T18:25:00Z", end_time: "2025-06-20T18:25:00Z", is_active: true}
  @update_attrs %{description: "some updated description", title: "some updated title", start_time: "2025-06-21T18:25:00Z", end_time: "2025-06-21T18:25:00Z", is_active: false}
  @invalid_attrs %{description: nil, title: nil, start_time: nil, end_time: nil, is_active: false}

  defp create_server_event(_) do
    server_event = server_event_fixture()
    %{server_event: server_event}
  end

  describe "Index" do
    setup [:create_server_event]

    test "lists all events", %{conn: conn, server_event: server_event} do
      {:ok, _index_live, html} = live(conn, ~p"/events")

      assert html =~ "Listing Events"
      assert html =~ server_event.description
    end

    test "saves new server_event", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/events")

      assert index_live |> element("a", "New Server event") |> render_click() =~
               "New Server event"

      assert_patch(index_live, ~p"/events/new")

      assert index_live
             |> form("#server_event-form", server_event: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#server_event-form", server_event: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/events")

      html = render(index_live)
      assert html =~ "Server event created successfully"
      assert html =~ "some description"
    end

    test "updates server_event in listing", %{conn: conn, server_event: server_event} do
      {:ok, index_live, _html} = live(conn, ~p"/events")

      assert index_live |> element("#events-#{server_event.id} a", "Edit") |> render_click() =~
               "Edit Server event"

      assert_patch(index_live, ~p"/events/#{server_event}/edit")

      assert index_live
             |> form("#server_event-form", server_event: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#server_event-form", server_event: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/events")

      html = render(index_live)
      assert html =~ "Server event updated successfully"
      assert html =~ "some updated description"
    end

    test "deletes server_event in listing", %{conn: conn, server_event: server_event} do
      {:ok, index_live, _html} = live(conn, ~p"/events")

      assert index_live |> element("#events-#{server_event.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#events-#{server_event.id}")
    end
  end

  describe "Show" do
    setup [:create_server_event]

    test "displays server_event", %{conn: conn, server_event: server_event} do
      {:ok, _show_live, html} = live(conn, ~p"/events/#{server_event}")

      assert html =~ "Show Server event"
      assert html =~ server_event.description
    end

    test "updates server_event within modal", %{conn: conn, server_event: server_event} do
      {:ok, show_live, _html} = live(conn, ~p"/events/#{server_event}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Server event"

      assert_patch(show_live, ~p"/events/#{server_event}/show/edit")

      assert show_live
             |> form("#server_event-form", server_event: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#server_event-form", server_event: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/events/#{server_event}")

      html = render(show_live)
      assert html =~ "Server event updated successfully"
      assert html =~ "some updated description"
    end
  end
end

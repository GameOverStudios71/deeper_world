defmodule DeeperHubWeb.ServerUpdateMessageLiveTest do
  use DeeperHubWeb.ConnCase

  import Phoenix.LiveViewTest
  import DeeperHub.HubFixtures

  @create_attrs %{update_notes: "some update_notes", new_version: "some new_version", screenshoots: "some screenshoots", update_date: "2025-06-20T18:25:00Z"}
  @update_attrs %{update_notes: "some updated update_notes", new_version: "some updated new_version", screenshoots: "some updated screenshoots", update_date: "2025-06-21T18:25:00Z"}
  @invalid_attrs %{update_notes: nil, new_version: nil, screenshoots: nil, update_date: nil}

  defp create_server_update_message(_) do
    server_update_message = server_update_message_fixture()
    %{server_update_message: server_update_message}
  end

  describe "Index" do
    setup [:create_server_update_message]

    test "lists all server_update_messages", %{conn: conn, server_update_message: server_update_message} do
      {:ok, _index_live, html} = live(conn, ~p"/server_update_messages")

      assert html =~ "Listing Server update messages"
      assert html =~ server_update_message.update_notes
    end

    test "saves new server_update_message", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/server_update_messages")

      assert index_live |> element("a", "New Server update message") |> render_click() =~
               "New Server update message"

      assert_patch(index_live, ~p"/server_update_messages/new")

      assert index_live
             |> form("#server_update_message-form", server_update_message: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#server_update_message-form", server_update_message: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/server_update_messages")

      html = render(index_live)
      assert html =~ "Server update message created successfully"
      assert html =~ "some update_notes"
    end

    test "updates server_update_message in listing", %{conn: conn, server_update_message: server_update_message} do
      {:ok, index_live, _html} = live(conn, ~p"/server_update_messages")

      assert index_live |> element("#server_update_messages-#{server_update_message.id} a", "Edit") |> render_click() =~
               "Edit Server update message"

      assert_patch(index_live, ~p"/server_update_messages/#{server_update_message}/edit")

      assert index_live
             |> form("#server_update_message-form", server_update_message: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#server_update_message-form", server_update_message: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/server_update_messages")

      html = render(index_live)
      assert html =~ "Server update message updated successfully"
      assert html =~ "some updated update_notes"
    end

    test "deletes server_update_message in listing", %{conn: conn, server_update_message: server_update_message} do
      {:ok, index_live, _html} = live(conn, ~p"/server_update_messages")

      assert index_live |> element("#server_update_messages-#{server_update_message.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#server_update_messages-#{server_update_message.id}")
    end
  end

  describe "Show" do
    setup [:create_server_update_message]

    test "displays server_update_message", %{conn: conn, server_update_message: server_update_message} do
      {:ok, _show_live, html} = live(conn, ~p"/server_update_messages/#{server_update_message}")

      assert html =~ "Show Server update message"
      assert html =~ server_update_message.update_notes
    end

    test "updates server_update_message within modal", %{conn: conn, server_update_message: server_update_message} do
      {:ok, show_live, _html} = live(conn, ~p"/server_update_messages/#{server_update_message}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Server update message"

      assert_patch(show_live, ~p"/server_update_messages/#{server_update_message}/show/edit")

      assert show_live
             |> form("#server_update_message-form", server_update_message: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#server_update_message-form", server_update_message: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/server_update_messages/#{server_update_message}")

      html = render(show_live)
      assert html =~ "Server update message updated successfully"
      assert html =~ "some updated update_notes"
    end
  end
end

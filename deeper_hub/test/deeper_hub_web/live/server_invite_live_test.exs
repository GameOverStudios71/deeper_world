defmodule DeeperHubWeb.ServerInviteLiveTest do
  use DeeperHubWeb.ConnCase

  import Phoenix.LiveViewTest
  import DeeperHub.HubFixtures

  @create_attrs %{invite_code: "some invite_code", expires_at: "2025-06-20T17:59:00Z"}
  @update_attrs %{invite_code: "some updated invite_code", expires_at: "2025-06-21T17:59:00Z"}
  @invalid_attrs %{invite_code: nil, expires_at: nil}

  defp create_server_invite(_) do
    server_invite = server_invite_fixture()
    %{server_invite: server_invite}
  end

  describe "Index" do
    setup [:create_server_invite]

    test "lists all server_invites", %{conn: conn, server_invite: server_invite} do
      {:ok, _index_live, html} = live(conn, ~p"/server_invites")

      assert html =~ "Listing Server invites"
      assert html =~ server_invite.invite_code
    end

    test "saves new server_invite", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/server_invites")

      assert index_live |> element("a", "New Server invite") |> render_click() =~
               "New Server invite"

      assert_patch(index_live, ~p"/server_invites/new")

      assert index_live
             |> form("#server_invite-form", server_invite: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#server_invite-form", server_invite: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/server_invites")

      html = render(index_live)
      assert html =~ "Server invite created successfully"
      assert html =~ "some invite_code"
    end

    test "updates server_invite in listing", %{conn: conn, server_invite: server_invite} do
      {:ok, index_live, _html} = live(conn, ~p"/server_invites")

      assert index_live |> element("#server_invites-#{server_invite.id} a", "Edit") |> render_click() =~
               "Edit Server invite"

      assert_patch(index_live, ~p"/server_invites/#{server_invite}/edit")

      assert index_live
             |> form("#server_invite-form", server_invite: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#server_invite-form", server_invite: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/server_invites")

      html = render(index_live)
      assert html =~ "Server invite updated successfully"
      assert html =~ "some updated invite_code"
    end

    test "deletes server_invite in listing", %{conn: conn, server_invite: server_invite} do
      {:ok, index_live, _html} = live(conn, ~p"/server_invites")

      assert index_live |> element("#server_invites-#{server_invite.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#server_invites-#{server_invite.id}")
    end
  end

  describe "Show" do
    setup [:create_server_invite]

    test "displays server_invite", %{conn: conn, server_invite: server_invite} do
      {:ok, _show_live, html} = live(conn, ~p"/server_invites/#{server_invite}")

      assert html =~ "Show Server invite"
      assert html =~ server_invite.invite_code
    end

    test "updates server_invite within modal", %{conn: conn, server_invite: server_invite} do
      {:ok, show_live, _html} = live(conn, ~p"/server_invites/#{server_invite}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Server invite"

      assert_patch(show_live, ~p"/server_invites/#{server_invite}/show/edit")

      assert show_live
             |> form("#server_invite-form", server_invite: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#server_invite-form", server_invite: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/server_invites/#{server_invite}")

      html = render(show_live)
      assert html =~ "Server invite updated successfully"
      assert html =~ "some updated invite_code"
    end
  end
end

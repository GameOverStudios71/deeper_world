defmodule DeeperHubWeb.SupportTicketLiveTest do
  use DeeperHubWeb.ConnCase

  import Phoenix.LiveViewTest
  import DeeperHub.HubFixtures

  @create_attrs %{status: "some status", issue_description: "some issue_description"}
  @update_attrs %{status: "some updated status", issue_description: "some updated issue_description"}
  @invalid_attrs %{status: nil, issue_description: nil}

  defp create_support_ticket(_) do
    support_ticket = support_ticket_fixture()
    %{support_ticket: support_ticket}
  end

  describe "Index" do
    setup [:create_support_ticket]

    test "lists all support_tickets", %{conn: conn, support_ticket: support_ticket} do
      {:ok, _index_live, html} = live(conn, ~p"/support_tickets")

      assert html =~ "Listing Support tickets"
      assert html =~ support_ticket.status
    end

    test "saves new support_ticket", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/support_tickets")

      assert index_live |> element("a", "New Support ticket") |> render_click() =~
               "New Support ticket"

      assert_patch(index_live, ~p"/support_tickets/new")

      assert index_live
             |> form("#support_ticket-form", support_ticket: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#support_ticket-form", support_ticket: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/support_tickets")

      html = render(index_live)
      assert html =~ "Support ticket created successfully"
      assert html =~ "some status"
    end

    test "updates support_ticket in listing", %{conn: conn, support_ticket: support_ticket} do
      {:ok, index_live, _html} = live(conn, ~p"/support_tickets")

      assert index_live |> element("#support_tickets-#{support_ticket.id} a", "Edit") |> render_click() =~
               "Edit Support ticket"

      assert_patch(index_live, ~p"/support_tickets/#{support_ticket}/edit")

      assert index_live
             |> form("#support_ticket-form", support_ticket: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#support_ticket-form", support_ticket: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/support_tickets")

      html = render(index_live)
      assert html =~ "Support ticket updated successfully"
      assert html =~ "some updated status"
    end

    test "deletes support_ticket in listing", %{conn: conn, support_ticket: support_ticket} do
      {:ok, index_live, _html} = live(conn, ~p"/support_tickets")

      assert index_live |> element("#support_tickets-#{support_ticket.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#support_tickets-#{support_ticket.id}")
    end
  end

  describe "Show" do
    setup [:create_support_ticket]

    test "displays support_ticket", %{conn: conn, support_ticket: support_ticket} do
      {:ok, _show_live, html} = live(conn, ~p"/support_tickets/#{support_ticket}")

      assert html =~ "Show Support ticket"
      assert html =~ support_ticket.status
    end

    test "updates support_ticket within modal", %{conn: conn, support_ticket: support_ticket} do
      {:ok, show_live, _html} = live(conn, ~p"/support_tickets/#{support_ticket}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Support ticket"

      assert_patch(show_live, ~p"/support_tickets/#{support_ticket}/show/edit")

      assert show_live
             |> form("#support_ticket-form", support_ticket: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#support_ticket-form", support_ticket: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/support_tickets/#{support_ticket}")

      html = render(show_live)
      assert html =~ "Support ticket updated successfully"
      assert html =~ "some updated status"
    end
  end
end

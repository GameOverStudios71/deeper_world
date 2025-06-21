defmodule DeeperHubWeb.SupportTicketLive.Index do
  use DeeperHubWeb, :live_view

  alias DeeperHub.Hub
  alias DeeperHub.Hub.SupportTicket

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :support_tickets, Hub.list_support_tickets())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Support ticket")
    |> assign(:support_ticket, Hub.get_support_ticket!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Support ticket")
    |> assign(:support_ticket, %SupportTicket{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Support tickets")
    |> assign(:support_ticket, nil)
  end

  @impl true
  def handle_info({DeeperHubWeb.SupportTicketLive.FormComponent, {:saved, support_ticket}}, socket) do
    {:noreply, stream_insert(socket, :support_tickets, support_ticket)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    support_ticket = Hub.get_support_ticket!(id)
    {:ok, _} = Hub.delete_support_ticket(support_ticket)

    {:noreply, stream_delete(socket, :support_tickets, support_ticket)}
  end
end

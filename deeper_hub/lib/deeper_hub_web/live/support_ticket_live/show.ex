defmodule DeeperHubWeb.SupportTicketLive.Show do
  use DeeperHubWeb, :live_view

  alias DeeperHub.Hub

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:support_ticket, Hub.get_support_ticket!(id))}
  end

  defp page_title(:show), do: "Show Support ticket"
  defp page_title(:edit), do: "Edit Support ticket"
end

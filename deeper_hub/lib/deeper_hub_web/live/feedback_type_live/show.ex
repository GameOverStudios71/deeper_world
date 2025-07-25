defmodule DeeperHubWeb.FeedbackTypeLive.Show do
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
     |> assign(:feedback_type, Hub.get_feedback_type!(id))}
  end

  defp page_title(:show), do: "Show Feedback type"
  defp page_title(:edit), do: "Edit Feedback type"
end

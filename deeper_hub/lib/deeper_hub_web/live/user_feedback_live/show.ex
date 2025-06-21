defmodule DeeperHubWeb.UserFeedbackLive.Show do
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
     |> assign(:user_feedback, Hub.get_user_feedback!(id))}
  end

  defp page_title(:show), do: "Show User feedback"
  defp page_title(:edit), do: "Edit User feedback"
end

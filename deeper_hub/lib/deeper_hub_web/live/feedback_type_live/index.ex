defmodule DeeperHubWeb.FeedbackTypeLive.Index do
  use DeeperHubWeb, :live_view

  alias DeeperHub.Hub
  alias DeeperHub.Hub.FeedbackType

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :feedback_types, Hub.list_feedback_types())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Feedback type")
    |> assign(:feedback_type, Hub.get_feedback_type!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Feedback type")
    |> assign(:feedback_type, %FeedbackType{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Feedback types")
    |> assign(:feedback_type, nil)
  end

  @impl true
  def handle_info({DeeperHubWeb.FeedbackTypeLive.FormComponent, {:saved, feedback_type}}, socket) do
    {:noreply, stream_insert(socket, :feedback_types, feedback_type)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    feedback_type = Hub.get_feedback_type!(id)
    {:ok, _} = Hub.delete_feedback_type(feedback_type)

    {:noreply, stream_delete(socket, :feedback_types, feedback_type)}
  end
end

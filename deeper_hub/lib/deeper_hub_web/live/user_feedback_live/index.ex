defmodule DeeperHubWeb.UserFeedbackLive.Index do
  use DeeperHubWeb, :live_view

  alias DeeperHub.Hub
  alias DeeperHub.Hub.UserFeedback

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :user_feedback_collection, Hub.list_user_feedback())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit User feedback")
    |> assign(:user_feedback, Hub.get_user_feedback!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New User feedback")
    |> assign(:user_feedback, %UserFeedback{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing User feedback")
    |> assign(:user_feedback, nil)
  end

  @impl true
  def handle_info({DeeperHubWeb.UserFeedbackLive.FormComponent, {:saved, user_feedback}}, socket) do
    {:noreply, stream_insert(socket, :user_feedback_collection, user_feedback)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    user_feedback = Hub.get_user_feedback!(id)
    {:ok, _} = Hub.delete_user_feedback(user_feedback)

    {:noreply, stream_delete(socket, :user_feedback_collection, user_feedback)}
  end
end

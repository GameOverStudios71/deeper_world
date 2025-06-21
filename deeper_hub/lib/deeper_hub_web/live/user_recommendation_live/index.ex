defmodule DeeperHubWeb.UserRecommendationLive.Index do
  use DeeperHubWeb, :live_view

  alias DeeperHub.Hub
  alias DeeperHub.Hub.UserRecommendation

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :user_recommendations, Hub.list_user_recommendations())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit User recommendation")
    |> assign(:user_recommendation, Hub.get_user_recommendation!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New User recommendation")
    |> assign(:user_recommendation, %UserRecommendation{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing User recommendations")
    |> assign(:user_recommendation, nil)
  end

  @impl true
  def handle_info({DeeperHubWeb.UserRecommendationLive.FormComponent, {:saved, user_recommendation}}, socket) do
    {:noreply, stream_insert(socket, :user_recommendations, user_recommendation)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    user_recommendation = Hub.get_user_recommendation!(id)
    {:ok, _} = Hub.delete_user_recommendation(user_recommendation)

    {:noreply, stream_delete(socket, :user_recommendations, user_recommendation)}
  end
end

defmodule DeeperHubWeb.AchievementTypeLive.Index do
  use DeeperHubWeb, :live_view

  alias DeeperHub.Hub
  alias DeeperHub.Hub.AchievementType

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :achievement_types, Hub.list_achievement_types())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Achievement type")
    |> assign(:achievement_type, Hub.get_achievement_type!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Achievement type")
    |> assign(:achievement_type, %AchievementType{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Achievement types")
    |> assign(:achievement_type, nil)
  end

  @impl true
  def handle_info({DeeperHubWeb.AchievementTypeLive.FormComponent, {:saved, achievement_type}}, socket) do
    {:noreply, stream_insert(socket, :achievement_types, achievement_type)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    achievement_type = Hub.get_achievement_type!(id)
    {:ok, _} = Hub.delete_achievement_type(achievement_type)

    {:noreply, stream_delete(socket, :achievement_types, achievement_type)}
  end
end

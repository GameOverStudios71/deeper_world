defmodule DeeperHubWeb.ServerEventLive.Index do
  use DeeperHubWeb, :live_view

  alias DeeperHub.Hub
  alias DeeperHub.Hub.ServerEvent

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :events, Hub.list_events())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Server event")
    |> assign(:server_event, Hub.get_server_event!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Server event")
    |> assign(:server_event, %ServerEvent{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Events")
    |> assign(:server_event, nil)
  end

  @impl true
  def handle_info({DeeperHubWeb.ServerEventLive.FormComponent, {:saved, server_event}}, socket) do
    {:noreply, stream_insert(socket, :events, server_event)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    server_event = Hub.get_server_event!(id)
    {:ok, _} = Hub.delete_server_event(server_event)

    {:noreply, stream_delete(socket, :events, server_event)}
  end
end

defmodule DeeperHubWeb.ServerUpdateMessageLive.Index do
  use DeeperHubWeb, :live_view

  alias DeeperHub.Hub
  alias DeeperHub.Hub.ServerUpdateMessage

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :server_update_messages, Hub.list_server_update_messages())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Server update message")
    |> assign(:server_update_message, Hub.get_server_update_message!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Server update message")
    |> assign(:server_update_message, %ServerUpdateMessage{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Server update messages")
    |> assign(:server_update_message, nil)
  end

  @impl true
  def handle_info({DeeperHubWeb.ServerUpdateMessageLive.FormComponent, {:saved, server_update_message}}, socket) do
    {:noreply, stream_insert(socket, :server_update_messages, server_update_message)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    server_update_message = Hub.get_server_update_message!(id)
    {:ok, _} = Hub.delete_server_update_message(server_update_message)

    {:noreply, stream_delete(socket, :server_update_messages, server_update_message)}
  end
end

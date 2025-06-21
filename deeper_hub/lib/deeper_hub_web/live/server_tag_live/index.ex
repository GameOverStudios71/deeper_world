defmodule DeeperHubWeb.ServerTagLive.Index do
  use DeeperHubWeb, :live_view

  alias DeeperHub.Hub
  alias DeeperHub.Hub.ServerTag

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :server_tags, Hub.list_server_tags())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Server tag")
    |> assign(:server_tag, Hub.get_server_tag!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Server tag")
    |> assign(:server_tag, %ServerTag{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Server tags")
    |> assign(:server_tag, nil)
  end

  @impl true
  def handle_info({DeeperHubWeb.ServerTagLive.FormComponent, {:saved, server_tag}}, socket) do
    {:noreply, stream_insert(socket, :server_tags, server_tag)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    server_tag = Hub.get_server_tag!(id)
    {:ok, _} = Hub.delete_server_tag(server_tag)

    {:noreply, stream_delete(socket, :server_tags, server_tag)}
  end
end

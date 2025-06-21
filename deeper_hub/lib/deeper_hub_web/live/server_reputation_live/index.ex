defmodule DeeperHubWeb.ServerReputationLive.Index do
  use DeeperHubWeb, :live_view

  alias DeeperHub.Hub
  alias DeeperHub.Hub.ServerReputation

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :server_reputation_collection, Hub.list_server_reputation())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Server reputation")
    |> assign(:server_reputation, Hub.get_server_reputation!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Server reputation")
    |> assign(:server_reputation, %ServerReputation{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Server reputation")
    |> assign(:server_reputation, nil)
  end

  @impl true
  def handle_info({DeeperHubWeb.ServerReputationLive.FormComponent, {:saved, server_reputation}}, socket) do
    {:noreply, stream_insert(socket, :server_reputation_collection, server_reputation)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    server_reputation = Hub.get_server_reputation!(id)
    {:ok, _} = Hub.delete_server_reputation(server_reputation)

    {:noreply, stream_delete(socket, :server_reputation_collection, server_reputation)}
  end
end

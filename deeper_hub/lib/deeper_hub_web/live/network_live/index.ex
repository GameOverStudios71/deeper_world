defmodule DeeperHubWeb.NetworkLive.Index do
  use DeeperHubWeb, :live_view

  alias DeeperHub.Hub
  alias DeeperHub.Hub.Network

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :networks, Hub.list_networks())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Network")
    |> assign(:network, Hub.get_network!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Network")
    |> assign(:network, %Network{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Networks")
    |> assign(:network, nil)
  end

  @impl true
  def handle_info({DeeperHubWeb.NetworkLive.FormComponent, {:saved, network}}, socket) do
    {:noreply, stream_insert(socket, :networks, network)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    network = Hub.get_network!(id)
    {:ok, _} = Hub.delete_network(network)

    {:noreply, stream_delete(socket, :networks, network)}
  end
end

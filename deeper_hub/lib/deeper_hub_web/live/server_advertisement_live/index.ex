defmodule DeeperHubWeb.ServerAdvertisementLive.Index do
  use DeeperHubWeb, :live_view

  alias DeeperHub.Hub
  alias DeeperHub.Hub.ServerAdvertisement

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :advertisements, Hub.list_advertisements())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Server advertisement")
    |> assign(:server_advertisement, Hub.get_server_advertisement!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Server advertisement")
    |> assign(:server_advertisement, %ServerAdvertisement{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Advertisements")
    |> assign(:server_advertisement, nil)
  end

  @impl true
  def handle_info({DeeperHubWeb.ServerAdvertisementLive.FormComponent, {:saved, server_advertisement}}, socket) do
    {:noreply, stream_insert(socket, :advertisements, server_advertisement)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    server_advertisement = Hub.get_server_advertisement!(id)
    {:ok, _} = Hub.delete_server_advertisement(server_advertisement)

    {:noreply, stream_delete(socket, :advertisements, server_advertisement)}
  end
end

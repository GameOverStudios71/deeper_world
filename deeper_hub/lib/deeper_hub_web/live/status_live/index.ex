defmodule DeeperHubWeb.StatusLive.Index do
  use DeeperHubWeb, :live_view

  alias DeeperHub.Hub
  alias DeeperHub.Hub.Status

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :statuses, Hub.list_statuses())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Status")
    |> assign(:status, Hub.get_status!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Status")
    |> assign(:status, %Status{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Statuses")
    |> assign(:status, nil)
  end

  @impl true
  def handle_info({DeeperHubWeb.StatusLive.FormComponent, {:saved, status}}, socket) do
    {:noreply, stream_insert(socket, :statuses, status)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    status = Hub.get_status!(id)
    {:ok, _} = Hub.delete_status(status)

    {:noreply, stream_delete(socket, :statuses, status)}
  end
end

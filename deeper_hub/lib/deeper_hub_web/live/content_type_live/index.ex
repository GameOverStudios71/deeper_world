defmodule DeeperHubWeb.ContentTypeLive.Index do
  use DeeperHubWeb, :live_view

  alias DeeperHub.Hub
  alias DeeperHub.Hub.ContentType

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :content_types, Hub.list_content_types())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Content type")
    |> assign(:content_type, Hub.get_content_type!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Content type")
    |> assign(:content_type, %ContentType{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Content types")
    |> assign(:content_type, nil)
  end

  @impl true
  def handle_info({DeeperHubWeb.ContentTypeLive.FormComponent, {:saved, content_type}}, socket) do
    {:noreply, stream_insert(socket, :content_types, content_type)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    content_type = Hub.get_content_type!(id)
    {:ok, _} = Hub.delete_content_type(content_type)

    {:noreply, stream_delete(socket, :content_types, content_type)}
  end
end

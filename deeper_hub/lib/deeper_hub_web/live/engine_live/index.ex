defmodule DeeperHubWeb.EngineLive.Index do
  use DeeperHubWeb, :live_view

  alias DeeperHub.Hub
  alias DeeperHub.Hub.Engine

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :engines, Hub.list_engines())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Engine")
    |> assign(:engine, Hub.get_engine!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Engine")
    |> assign(:engine, %Engine{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Engines")
    |> assign(:engine, nil)
  end

  @impl true
  def handle_info({DeeperHubWeb.EngineLive.FormComponent, {:saved, engine}}, socket) do
    {:noreply, stream_insert(socket, :engines, engine)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    engine = Hub.get_engine!(id)
    {:ok, _} = Hub.delete_engine(engine)

    {:noreply, stream_delete(socket, :engines, engine)}
  end
end

defmodule DeeperHubWeb.ServerInviteLive.Index do
  use DeeperHubWeb, :live_view

  alias DeeperHub.Hub
  alias DeeperHub.Hub.ServerInvite

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :server_invites, Hub.list_server_invites())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Server invite")
    |> assign(:server_invite, Hub.get_server_invite!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Server invite")
    |> assign(:server_invite, %ServerInvite{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Server invites")
    |> assign(:server_invite, nil)
  end

  @impl true
  def handle_info({DeeperHubWeb.ServerInviteLive.FormComponent, {:saved, server_invite}}, socket) do
    {:noreply, stream_insert(socket, :server_invites, server_invite)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    server_invite = Hub.get_server_invite!(id)
    {:ok, _} = Hub.delete_server_invite(server_invite)

    {:noreply, stream_delete(socket, :server_invites, server_invite)}
  end
end

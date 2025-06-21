defmodule DeeperHubWeb.ServerReviewLive.Index do
  use DeeperHubWeb, :live_view

  alias DeeperHub.Hub
  alias DeeperHub.Hub.ServerReview

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :reviews, Hub.list_reviews())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Server review")
    |> assign(:server_review, Hub.get_server_review!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Server review")
    |> assign(:server_review, %ServerReview{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Reviews")
    |> assign(:server_review, nil)
  end

  @impl true
  def handle_info({DeeperHubWeb.ServerReviewLive.FormComponent, {:saved, server_review}}, socket) do
    {:noreply, stream_insert(socket, :reviews, server_review)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    server_review = Hub.get_server_review!(id)
    {:ok, _} = Hub.delete_server_review(server_review)

    {:noreply, stream_delete(socket, :reviews, server_review)}
  end
end

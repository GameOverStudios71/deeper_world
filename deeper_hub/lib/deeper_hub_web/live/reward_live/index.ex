defmodule DeeperHubWeb.RewardLive.Index do
  use DeeperHubWeb, :live_view

  alias DeeperHub.Hub
  alias DeeperHub.Hub.Reward

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :rewards, Hub.list_rewards())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Reward")
    |> assign(:reward, Hub.get_reward!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Reward")
    |> assign(:reward, %Reward{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Rewards")
    |> assign(:reward, nil)
  end

  @impl true
  def handle_info({DeeperHubWeb.RewardLive.FormComponent, {:saved, reward}}, socket) do
    {:noreply, stream_insert(socket, :rewards, reward)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    reward = Hub.get_reward!(id)
    {:ok, _} = Hub.delete_reward(reward)

    {:noreply, stream_delete(socket, :rewards, reward)}
  end
end

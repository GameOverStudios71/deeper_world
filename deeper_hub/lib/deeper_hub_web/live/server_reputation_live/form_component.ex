defmodule DeeperHubWeb.ServerReputationLive.FormComponent do
  use DeeperHubWeb, :live_component

  alias DeeperHub.Hub

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage server_reputation records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="server_reputation-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:reputation_score]} type="number" label="Reputation score" />
        <.input field={@form[:last_updated]} type="datetime-local" label="Last updated" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Server reputation</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{server_reputation: server_reputation} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Hub.change_server_reputation(server_reputation))
     end)}
  end

  @impl true
  def handle_event("validate", %{"server_reputation" => server_reputation_params}, socket) do
    changeset = Hub.change_server_reputation(socket.assigns.server_reputation, server_reputation_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"server_reputation" => server_reputation_params}, socket) do
    save_server_reputation(socket, socket.assigns.action, server_reputation_params)
  end

  defp save_server_reputation(socket, :edit, server_reputation_params) do
    case Hub.update_server_reputation(socket.assigns.server_reputation, server_reputation_params) do
      {:ok, server_reputation} ->
        notify_parent({:saved, server_reputation})

        {:noreply,
         socket
         |> put_flash(:info, "Server reputation updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_server_reputation(socket, :new, server_reputation_params) do
    case Hub.create_server_reputation(server_reputation_params) do
      {:ok, server_reputation} ->
        notify_parent({:saved, server_reputation})

        {:noreply,
         socket
         |> put_flash(:info, "Server reputation created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end

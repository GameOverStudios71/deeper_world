defmodule DeeperHubWeb.ServerInviteLive.FormComponent do
  use DeeperHubWeb, :live_component

  alias DeeperHub.Hub

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage server_invite records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="server_invite-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:invite_code]} type="text" label="Invite code" />
        <.input field={@form[:expires_at]} type="datetime-local" label="Expires at" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Server invite</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{server_invite: server_invite} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Hub.change_server_invite(server_invite))
     end)}
  end

  @impl true
  def handle_event("validate", %{"server_invite" => server_invite_params}, socket) do
    changeset = Hub.change_server_invite(socket.assigns.server_invite, server_invite_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"server_invite" => server_invite_params}, socket) do
    save_server_invite(socket, socket.assigns.action, server_invite_params)
  end

  defp save_server_invite(socket, :edit, server_invite_params) do
    case Hub.update_server_invite(socket.assigns.server_invite, server_invite_params) do
      {:ok, server_invite} ->
        notify_parent({:saved, server_invite})

        {:noreply,
         socket
         |> put_flash(:info, "Server invite updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_server_invite(socket, :new, server_invite_params) do
    case Hub.create_server_invite(server_invite_params) do
      {:ok, server_invite} ->
        notify_parent({:saved, server_invite})

        {:noreply,
         socket
         |> put_flash(:info, "Server invite created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end

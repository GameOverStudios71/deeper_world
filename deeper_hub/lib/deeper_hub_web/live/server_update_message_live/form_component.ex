defmodule DeeperHubWeb.ServerUpdateMessageLive.FormComponent do
  use DeeperHubWeb, :live_component

  alias DeeperHub.Hub

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage server_update_message records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="server_update_message-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:update_notes]} type="text" label="Update notes" />
        <.input field={@form[:new_version]} type="text" label="New version" />
        <.input field={@form[:screenshoots]} type="text" label="Screenshoots" />
        <.input field={@form[:update_date]} type="datetime-local" label="Update date" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Server update message</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{server_update_message: server_update_message} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Hub.change_server_update_message(server_update_message))
     end)}
  end

  @impl true
  def handle_event("validate", %{"server_update_message" => server_update_message_params}, socket) do
    changeset = Hub.change_server_update_message(socket.assigns.server_update_message, server_update_message_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"server_update_message" => server_update_message_params}, socket) do
    save_server_update_message(socket, socket.assigns.action, server_update_message_params)
  end

  defp save_server_update_message(socket, :edit, server_update_message_params) do
    case Hub.update_server_update_message(socket.assigns.server_update_message, server_update_message_params) do
      {:ok, server_update_message} ->
        notify_parent({:saved, server_update_message})

        {:noreply,
         socket
         |> put_flash(:info, "Server update message updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_server_update_message(socket, :new, server_update_message_params) do
    case Hub.create_server_update_message(server_update_message_params) do
      {:ok, server_update_message} ->
        notify_parent({:saved, server_update_message})

        {:noreply,
         socket
         |> put_flash(:info, "Server update message created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end

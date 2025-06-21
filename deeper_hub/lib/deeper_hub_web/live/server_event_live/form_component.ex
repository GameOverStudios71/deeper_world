defmodule DeeperHubWeb.ServerEventLive.FormComponent do
  use DeeperHubWeb, :live_component

  alias DeeperHub.Hub

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage server_event records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="server_event-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:title]} type="text" label="Title" />
        <.input field={@form[:description]} type="text" label="Description" />
        <.input field={@form[:start_time]} type="datetime-local" label="Start time" />
        <.input field={@form[:end_time]} type="datetime-local" label="End time" />
        <.input field={@form[:is_active]} type="checkbox" label="Is active" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Server event</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{server_event: server_event} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Hub.change_server_event(server_event))
     end)}
  end

  @impl true
  def handle_event("validate", %{"server_event" => server_event_params}, socket) do
    changeset = Hub.change_server_event(socket.assigns.server_event, server_event_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"server_event" => server_event_params}, socket) do
    save_server_event(socket, socket.assigns.action, server_event_params)
  end

  defp save_server_event(socket, :edit, server_event_params) do
    case Hub.update_server_event(socket.assigns.server_event, server_event_params) do
      {:ok, server_event} ->
        notify_parent({:saved, server_event})

        {:noreply,
         socket
         |> put_flash(:info, "Server event updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_server_event(socket, :new, server_event_params) do
    case Hub.create_server_event(server_event_params) do
      {:ok, server_event} ->
        notify_parent({:saved, server_event})

        {:noreply,
         socket
         |> put_flash(:info, "Server event created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end

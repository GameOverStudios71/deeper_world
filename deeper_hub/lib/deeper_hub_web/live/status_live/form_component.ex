defmodule DeeperHubWeb.StatusLive.FormComponent do
  use DeeperHubWeb, :live_component

  alias DeeperHub.Hub

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage status records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="status-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Status</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{status: status} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Hub.change_status(status))
     end)}
  end

  @impl true
  def handle_event("validate", %{"status" => status_params}, socket) do
    changeset = Hub.change_status(socket.assigns.status, status_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"status" => status_params}, socket) do
    save_status(socket, socket.assigns.action, status_params)
  end

  defp save_status(socket, :edit, status_params) do
    case Hub.update_status(socket.assigns.status, status_params) do
      {:ok, status} ->
        notify_parent({:saved, status})

        {:noreply,
         socket
         |> put_flash(:info, "Status updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_status(socket, :new, status_params) do
    case Hub.create_status(status_params) do
      {:ok, status} ->
        notify_parent({:saved, status})

        {:noreply,
         socket
         |> put_flash(:info, "Status created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end

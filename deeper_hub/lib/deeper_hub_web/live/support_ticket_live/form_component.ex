defmodule DeeperHubWeb.SupportTicketLive.FormComponent do
  use DeeperHubWeb, :live_component

  alias DeeperHub.Hub

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage support_ticket records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="support_ticket-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:issue_description]} type="text" label="Issue description" />
        <.input field={@form[:status]} type="text" label="Status" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Support ticket</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{support_ticket: support_ticket} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Hub.change_support_ticket(support_ticket))
     end)}
  end

  @impl true
  def handle_event("validate", %{"support_ticket" => support_ticket_params}, socket) do
    changeset = Hub.change_support_ticket(socket.assigns.support_ticket, support_ticket_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"support_ticket" => support_ticket_params}, socket) do
    save_support_ticket(socket, socket.assigns.action, support_ticket_params)
  end

  defp save_support_ticket(socket, :edit, support_ticket_params) do
    case Hub.update_support_ticket(socket.assigns.support_ticket, support_ticket_params) do
      {:ok, support_ticket} ->
        notify_parent({:saved, support_ticket})

        {:noreply,
         socket
         |> put_flash(:info, "Support ticket updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_support_ticket(socket, :new, support_ticket_params) do
    case Hub.create_support_ticket(support_ticket_params) do
      {:ok, support_ticket} ->
        notify_parent({:saved, support_ticket})

        {:noreply,
         socket
         |> put_flash(:info, "Support ticket created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end

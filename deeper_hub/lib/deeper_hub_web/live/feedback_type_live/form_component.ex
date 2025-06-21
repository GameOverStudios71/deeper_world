defmodule DeeperHubWeb.FeedbackTypeLive.FormComponent do
  use DeeperHubWeb, :live_component

  alias DeeperHub.Hub

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage feedback_type records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="feedback_type-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:description]} type="text" label="Description" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Feedback type</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{feedback_type: feedback_type} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Hub.change_feedback_type(feedback_type))
     end)}
  end

  @impl true
  def handle_event("validate", %{"feedback_type" => feedback_type_params}, socket) do
    changeset = Hub.change_feedback_type(socket.assigns.feedback_type, feedback_type_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"feedback_type" => feedback_type_params}, socket) do
    save_feedback_type(socket, socket.assigns.action, feedback_type_params)
  end

  defp save_feedback_type(socket, :edit, feedback_type_params) do
    case Hub.update_feedback_type(socket.assigns.feedback_type, feedback_type_params) do
      {:ok, feedback_type} ->
        notify_parent({:saved, feedback_type})

        {:noreply,
         socket
         |> put_flash(:info, "Feedback type updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_feedback_type(socket, :new, feedback_type_params) do
    case Hub.create_feedback_type(feedback_type_params) do
      {:ok, feedback_type} ->
        notify_parent({:saved, feedback_type})

        {:noreply,
         socket
         |> put_flash(:info, "Feedback type created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end

defmodule DeeperHubWeb.UserFeedbackLive.FormComponent do
  use DeeperHubWeb, :live_component

  alias DeeperHub.Hub

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage user_feedback records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="user_feedback-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:feedback_text]} type="text" label="Feedback text" />
        <.input field={@form[:submitted_at]} type="datetime-local" label="Submitted at" />
        <:actions>
          <.button phx-disable-with="Saving...">Save User feedback</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{user_feedback: user_feedback} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Hub.change_user_feedback(user_feedback))
     end)}
  end

  @impl true
  def handle_event("validate", %{"user_feedback" => user_feedback_params}, socket) do
    changeset = Hub.change_user_feedback(socket.assigns.user_feedback, user_feedback_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"user_feedback" => user_feedback_params}, socket) do
    save_user_feedback(socket, socket.assigns.action, user_feedback_params)
  end

  defp save_user_feedback(socket, :edit, user_feedback_params) do
    case Hub.update_user_feedback(socket.assigns.user_feedback, user_feedback_params) do
      {:ok, user_feedback} ->
        notify_parent({:saved, user_feedback})

        {:noreply,
         socket
         |> put_flash(:info, "User feedback updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_user_feedback(socket, :new, user_feedback_params) do
    case Hub.create_user_feedback(user_feedback_params) do
      {:ok, user_feedback} ->
        notify_parent({:saved, user_feedback})

        {:noreply,
         socket
         |> put_flash(:info, "User feedback created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end

defmodule DeeperHubWeb.UserRecommendationLive.FormComponent do
  use DeeperHubWeb, :live_component

  alias DeeperHub.Hub

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage user_recommendation records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="user_recommendation-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:recommendation_score]} type="number" label="Recommendation score" step="any" />
        <:actions>
          <.button phx-disable-with="Saving...">Save User recommendation</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{user_recommendation: user_recommendation} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Hub.change_user_recommendation(user_recommendation))
     end)}
  end

  @impl true
  def handle_event("validate", %{"user_recommendation" => user_recommendation_params}, socket) do
    changeset = Hub.change_user_recommendation(socket.assigns.user_recommendation, user_recommendation_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"user_recommendation" => user_recommendation_params}, socket) do
    save_user_recommendation(socket, socket.assigns.action, user_recommendation_params)
  end

  defp save_user_recommendation(socket, :edit, user_recommendation_params) do
    case Hub.update_user_recommendation(socket.assigns.user_recommendation, user_recommendation_params) do
      {:ok, user_recommendation} ->
        notify_parent({:saved, user_recommendation})

        {:noreply,
         socket
         |> put_flash(:info, "User recommendation updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_user_recommendation(socket, :new, user_recommendation_params) do
    case Hub.create_user_recommendation(user_recommendation_params) do
      {:ok, user_recommendation} ->
        notify_parent({:saved, user_recommendation})

        {:noreply,
         socket
         |> put_flash(:info, "User recommendation created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end

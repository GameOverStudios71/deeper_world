defmodule DeeperHubWeb.RatingLive.FormComponent do
  use DeeperHubWeb, :live_component

  alias DeeperHub.Hub

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage rating records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="rating-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:rating]} type="number" label="Rating" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Rating</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{rating: rating} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Hub.change_rating(rating))
     end)}
  end

  @impl true
  def handle_event("validate", %{"rating" => rating_params}, socket) do
    changeset = Hub.change_rating(socket.assigns.rating, rating_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"rating" => rating_params}, socket) do
    save_rating(socket, socket.assigns.action, rating_params)
  end

  defp save_rating(socket, :edit, rating_params) do
    case Hub.update_rating(socket.assigns.rating, rating_params) do
      {:ok, rating} ->
        notify_parent({:saved, rating})

        {:noreply,
         socket
         |> put_flash(:info, "Rating updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_rating(socket, :new, rating_params) do
    case Hub.create_rating(rating_params) do
      {:ok, rating} ->
        notify_parent({:saved, rating})

        {:noreply,
         socket
         |> put_flash(:info, "Rating created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end

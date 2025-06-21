defmodule DeeperHubWeb.AchievementTypeLive.FormComponent do
  use DeeperHubWeb, :live_component

  alias DeeperHub.Hub

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage achievement_type records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="achievement_type-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:description]} type="text" label="Description" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Achievement type</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{achievement_type: achievement_type} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Hub.change_achievement_type(achievement_type))
     end)}
  end

  @impl true
  def handle_event("validate", %{"achievement_type" => achievement_type_params}, socket) do
    changeset = Hub.change_achievement_type(socket.assigns.achievement_type, achievement_type_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"achievement_type" => achievement_type_params}, socket) do
    save_achievement_type(socket, socket.assigns.action, achievement_type_params)
  end

  defp save_achievement_type(socket, :edit, achievement_type_params) do
    case Hub.update_achievement_type(socket.assigns.achievement_type, achievement_type_params) do
      {:ok, achievement_type} ->
        notify_parent({:saved, achievement_type})

        {:noreply,
         socket
         |> put_flash(:info, "Achievement type updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_achievement_type(socket, :new, achievement_type_params) do
    case Hub.create_achievement_type(achievement_type_params) do
      {:ok, achievement_type} ->
        notify_parent({:saved, achievement_type})

        {:noreply,
         socket
         |> put_flash(:info, "Achievement type created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end

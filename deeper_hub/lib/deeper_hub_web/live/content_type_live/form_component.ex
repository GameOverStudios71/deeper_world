defmodule DeeperHubWeb.ContentTypeLive.FormComponent do
  use DeeperHubWeb, :live_component

  alias DeeperHub.Hub

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage content_type records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="content_type-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Content type</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{content_type: content_type} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Hub.change_content_type(content_type))
     end)}
  end

  @impl true
  def handle_event("validate", %{"content_type" => content_type_params}, socket) do
    changeset = Hub.change_content_type(socket.assigns.content_type, content_type_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"content_type" => content_type_params}, socket) do
    save_content_type(socket, socket.assigns.action, content_type_params)
  end

  defp save_content_type(socket, :edit, content_type_params) do
    case Hub.update_content_type(socket.assigns.content_type, content_type_params) do
      {:ok, content_type} ->
        notify_parent({:saved, content_type})

        {:noreply,
         socket
         |> put_flash(:info, "Content type updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_content_type(socket, :new, content_type_params) do
    case Hub.create_content_type(content_type_params) do
      {:ok, content_type} ->
        notify_parent({:saved, content_type})

        {:noreply,
         socket
         |> put_flash(:info, "Content type created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end

defmodule DeeperHubWeb.EngineLive.FormComponent do
  use DeeperHubWeb, :live_component

  alias DeeperHub.Hub

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage engine records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="engine-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Engine</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{engine: engine} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Hub.change_engine(engine))
     end)}
  end

  @impl true
  def handle_event("validate", %{"engine" => engine_params}, socket) do
    changeset = Hub.change_engine(socket.assigns.engine, engine_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"engine" => engine_params}, socket) do
    save_engine(socket, socket.assigns.action, engine_params)
  end

  defp save_engine(socket, :edit, engine_params) do
    case Hub.update_engine(socket.assigns.engine, engine_params) do
      {:ok, engine} ->
        notify_parent({:saved, engine})

        {:noreply,
         socket
         |> put_flash(:info, "Engine updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_engine(socket, :new, engine_params) do
    case Hub.create_engine(engine_params) do
      {:ok, engine} ->
        notify_parent({:saved, engine})

        {:noreply,
         socket
         |> put_flash(:info, "Engine created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end

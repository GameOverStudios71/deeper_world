defmodule DeeperHubWeb.ServerAdvertisementLive.FormComponent do
  use DeeperHubWeb, :live_component

  alias DeeperHub.Hub

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage server_advertisement records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="server_advertisement-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:ad_title]} type="text" label="Ad title" />
        <.input field={@form[:ad_description]} type="text" label="Ad description" />
        <.input field={@form[:start_date]} type="datetime-local" label="Start date" />
        <.input field={@form[:end_date]} type="datetime-local" label="End date" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Server advertisement</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{server_advertisement: server_advertisement} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Hub.change_server_advertisement(server_advertisement))
     end)}
  end

  @impl true
  def handle_event("validate", %{"server_advertisement" => server_advertisement_params}, socket) do
    changeset = Hub.change_server_advertisement(socket.assigns.server_advertisement, server_advertisement_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"server_advertisement" => server_advertisement_params}, socket) do
    save_server_advertisement(socket, socket.assigns.action, server_advertisement_params)
  end

  defp save_server_advertisement(socket, :edit, server_advertisement_params) do
    case Hub.update_server_advertisement(socket.assigns.server_advertisement, server_advertisement_params) do
      {:ok, server_advertisement} ->
        notify_parent({:saved, server_advertisement})

        {:noreply,
         socket
         |> put_flash(:info, "Server advertisement updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_server_advertisement(socket, :new, server_advertisement_params) do
    case Hub.create_server_advertisement(server_advertisement_params) do
      {:ok, server_advertisement} ->
        notify_parent({:saved, server_advertisement})

        {:noreply,
         socket
         |> put_flash(:info, "Server advertisement created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end

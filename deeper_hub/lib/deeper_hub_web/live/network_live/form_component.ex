defmodule DeeperHubWeb.NetworkLive.FormComponent do
  use DeeperHubWeb, :live_component

  alias DeeperHub.Hub

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage network records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="network-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Network</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{network: network} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Hub.change_network(network))
     end)}
  end

  @impl true
  def handle_event("validate", %{"network" => network_params}, socket) do
    changeset = Hub.change_network(socket.assigns.network, network_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"network" => network_params}, socket) do
    save_network(socket, socket.assigns.action, network_params)
  end

  defp save_network(socket, :edit, network_params) do
    case Hub.update_network(socket.assigns.network, network_params) do
      {:ok, network} ->
        notify_parent({:saved, network})

        {:noreply,
         socket
         |> put_flash(:info, "Network updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_network(socket, :new, network_params) do
    case Hub.create_network(network_params) do
      {:ok, network} ->
        notify_parent({:saved, network})

        {:noreply,
         socket
         |> put_flash(:info, "Network created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end

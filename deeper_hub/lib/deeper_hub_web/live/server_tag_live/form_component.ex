defmodule DeeperHubWeb.ServerTagLive.FormComponent do
  use DeeperHubWeb, :live_component

  alias DeeperHub.Hub

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage server_tag records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="server_tag-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:tag]} type="text" label="Tag" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Server tag</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{server_tag: server_tag} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Hub.change_server_tag(server_tag))
     end)}
  end

  @impl true
  def handle_event("validate", %{"server_tag" => server_tag_params}, socket) do
    changeset = Hub.change_server_tag(socket.assigns.server_tag, server_tag_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"server_tag" => server_tag_params}, socket) do
    save_server_tag(socket, socket.assigns.action, server_tag_params)
  end

  defp save_server_tag(socket, :edit, server_tag_params) do
    case Hub.update_server_tag(socket.assigns.server_tag, server_tag_params) do
      {:ok, server_tag} ->
        notify_parent({:saved, server_tag})

        {:noreply,
         socket
         |> put_flash(:info, "Server tag updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_server_tag(socket, :new, server_tag_params) do
    case Hub.create_server_tag(server_tag_params) do
      {:ok, server_tag} ->
        notify_parent({:saved, server_tag})

        {:noreply,
         socket
         |> put_flash(:info, "Server tag created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end

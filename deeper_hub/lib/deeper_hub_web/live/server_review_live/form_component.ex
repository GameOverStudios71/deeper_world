defmodule DeeperHubWeb.ServerReviewLive.FormComponent do
  use DeeperHubWeb, :live_component

  alias DeeperHub.Hub

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage server_review records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="server_review-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:rating]} type="number" label="Rating" />
        <.input field={@form[:comments]} type="text" label="Comments" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Server review</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{server_review: server_review} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Hub.change_server_review(server_review))
     end)}
  end

  @impl true
  def handle_event("validate", %{"server_review" => server_review_params}, socket) do
    changeset = Hub.change_server_review(socket.assigns.server_review, server_review_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"server_review" => server_review_params}, socket) do
    save_server_review(socket, socket.assigns.action, server_review_params)
  end

  defp save_server_review(socket, :edit, server_review_params) do
    case Hub.update_server_review(socket.assigns.server_review, server_review_params) do
      {:ok, server_review} ->
        notify_parent({:saved, server_review})

        {:noreply,
         socket
         |> put_flash(:info, "Server review updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_server_review(socket, :new, server_review_params) do
    case Hub.create_server_review(server_review_params) do
      {:ok, server_review} ->
        notify_parent({:saved, server_review})

        {:noreply,
         socket
         |> put_flash(:info, "Server review created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end

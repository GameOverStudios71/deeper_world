defmodule DeeperHubWeb.ChallengeLive.FormComponent do
  use DeeperHubWeb, :live_component

  alias DeeperHub.Hub

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage challenge records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="challenge-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:challenge_name]} type="text" label="Challenge name" />
        <.input field={@form[:challenge_description]} type="text" label="Challenge description" />
        <.input field={@form[:points_reward]} type="number" label="Points reward" />
        <.input field={@form[:start_date]} type="datetime-local" label="Start date" />
        <.input field={@form[:end_date]} type="datetime-local" label="End date" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Challenge</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{challenge: challenge} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Hub.change_challenge(challenge))
     end)}
  end

  @impl true
  def handle_event("validate", %{"challenge" => challenge_params}, socket) do
    changeset = Hub.change_challenge(socket.assigns.challenge, challenge_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"challenge" => challenge_params}, socket) do
    save_challenge(socket, socket.assigns.action, challenge_params)
  end

  defp save_challenge(socket, :edit, challenge_params) do
    case Hub.update_challenge(socket.assigns.challenge, challenge_params) do
      {:ok, challenge} ->
        notify_parent({:saved, challenge})

        {:noreply,
         socket
         |> put_flash(:info, "Challenge updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_challenge(socket, :new, challenge_params) do
    case Hub.create_challenge(challenge_params) do
      {:ok, challenge} ->
        notify_parent({:saved, challenge})

        {:noreply,
         socket
         |> put_flash(:info, "Challenge created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end

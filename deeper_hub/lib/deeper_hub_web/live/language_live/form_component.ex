defmodule DeeperHubWeb.LanguageLive.FormComponent do
  use DeeperHubWeb, :live_component

  alias DeeperHub.Hub

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage language records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="language-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Language</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{language: language} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Hub.change_language(language))
     end)}
  end

  @impl true
  def handle_event("validate", %{"language" => language_params}, socket) do
    changeset = Hub.change_language(socket.assigns.language, language_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"language" => language_params}, socket) do
    save_language(socket, socket.assigns.action, language_params)
  end

  defp save_language(socket, :edit, language_params) do
    case Hub.update_language(socket.assigns.language, language_params) do
      {:ok, language} ->
        notify_parent({:saved, language})

        {:noreply,
         socket
         |> put_flash(:info, "Language updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_language(socket, :new, language_params) do
    case Hub.create_language(language_params) do
      {:ok, language} ->
        notify_parent({:saved, language})

        {:noreply,
         socket
         |> put_flash(:info, "Language created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end

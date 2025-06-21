defmodule DeeperHubWeb.ServerLive.FormComponent do
  use DeeperHubWeb, :live_component

  alias DeeperHub.Hub
  alias DeeperHub.Accounts

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage server records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="server-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:verified]} type="checkbox" label="Verified" />
        <.input field={@form[:latitude]} type="number" label="Latitude" step="any" />
        <.input field={@form[:longitude]} type="number" label="Longitude" step="any" />
        <.input field={@form[:country]} type="text" label="Country" />
        <.input field={@form[:region]} type="text" label="Region" />
        <.input field={@form[:city]} type="text" label="City" />
        <.input field={@form[:server_name]} type="text" label="Server name" />
        <.input field={@form[:url]} type="text" label="Url" />
        <.input field={@form[:description_hero]} type="text" label="Description hero" />
        <.input field={@form[:description_full]} type="textarea" label="Description full" />
        <.input field={@form[:ping_ms]} type="number" label="Ping ms" />
        <.input field={@form[:visited_users_lst_mounth]} type="number" label="Visited users lst mounth" />
        <.input field={@form[:reputation]} type="number" label="Reputation" />
        <.input field={@form[:ai_permission]} type="checkbox" label="Ai permission" />
        <.input field={@form[:ai_generated]} type="checkbox" label="Ai generated" />
        <.input field={@form[:server_rules]} type="textarea" label="Server rules" />
        <.input field={@form[:server_cpu_info]} type="text" label="Server cpu info" />
        <.input field={@form[:server_max_users]} type="number" label="Server max users" />
        <.input field={@form[:min_age]} type="number" label="Min age" />
        <.input field={@form[:picture_box]} type="text" label="Picture box" />
        <.input field={@form[:picture_icon]} type="text" label="Picture icon" />
        <.input field={@form[:picture_featured]} type="text" label="Picture featured" />
        <.input field={@form[:picture_mini]} type="text" label="Picture mini" />
        <.input field={@form[:screenshoots]} type="textarea" label="Screenshoots" />
        <.input field={@form[:feature_colors]} type="text" label="Feature colors" />
        <.input field={@form[:platform_version]} type="text" label="Platform version" />
        <.input field={@form[:allow_anonymous]} type="checkbox" label="Allow anonymous" />
        <.input field={@form[:max_connections]} type="number" label="Max connections" />
        <.input field={@form[:encryption_level]} type="text" label="Encryption level" />

        <.input field={@form[:owner_id]} type="select" label="Owner" options={@users} />
        <.input field={@form[:category_id]} type="select" label="Category" options={@categories} />
        <.input field={@form[:language_id]} type="select" label="Language" options={@languages} />
        <.input field={@form[:status_id]} type="select" label="Status" options={@statuses} />
        <.input field={@form[:engine_id]} type="select" label="Engine" options={@engines} />
        <.input field={@form[:network_id]} type="select" label="Network" options={@networks} />
        <.input field={@form[:content_type_id]} type="select" label="Content type" options={@content_types} />

        <:actions>
          <.button phx-disable-with="Saving...">Save Server</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{server: server} = assigns, socket) do
    changeset = Hub.change_server(server)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn -> to_form(changeset) end)
     |> assign_new(:categories, fn -> Hub.list_categories() |> Enum.map(&{&1.name, &1.id}) end)
     |> assign_new(:languages, fn -> Hub.list_languages() |> Enum.map(&{&1.name, &1.id}) end)
     |> assign_new(:statuses, fn -> Hub.list_statuses() |> Enum.map(&{&1.name, &1.id}) end)
     |> assign_new(:engines, fn -> Hub.list_engines() |> Enum.map(&{&1.name, &1.id}) end)
     |> assign_new(:networks, fn -> Hub.list_networks() |> Enum.map(&{&1.name, &1.id}) end)
     |> assign_new(:content_types, fn -> Hub.list_content_types() |> Enum.map(&{&1.name, &1.id}) end)
     |> assign_new(:users, fn -> Accounts.list_users() |> Enum.map(&{&1.email, &1.id}) end)}
  end

  @impl true
  def handle_event("validate", %{"server" => server_params}, socket) do
    changeset = Hub.change_server(socket.assigns.server, server_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"server" => server_params}, socket) do
    save_server(socket, socket.assigns.action, server_params)
  end

  defp save_server(socket, :edit, server_params) do
    case Hub.update_server(socket.assigns.server, server_params) do
      {:ok, server} ->
        notify_parent({:saved, server})

        {:noreply,
         socket
         |> put_flash(:info, "Server updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_server(socket, :new, server_params) do
    case Hub.create_server(server_params) do
      {:ok, server} ->
        notify_parent({:saved, server})

        {:noreply,
         socket
         |> put_flash(:info, "Server created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end

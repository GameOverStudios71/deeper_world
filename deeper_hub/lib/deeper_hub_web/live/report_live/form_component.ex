defmodule DeeperHubWeb.ReportLive.FormComponent do
  use DeeperHubWeb, :live_component

  alias DeeperHub.Hub

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage report records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="report-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:report_type]} type="text" label="Report type" />
        <.input field={@form[:report_details]} type="text" label="Report details" />
        <.input field={@form[:reported_at]} type="datetime-local" label="Reported at" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Report</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{report: report} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Hub.change_report(report))
     end)}
  end

  @impl true
  def handle_event("validate", %{"report" => report_params}, socket) do
    changeset = Hub.change_report(socket.assigns.report, report_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"report" => report_params}, socket) do
    save_report(socket, socket.assigns.action, report_params)
  end

  defp save_report(socket, :edit, report_params) do
    case Hub.update_report(socket.assigns.report, report_params) do
      {:ok, report} ->
        notify_parent({:saved, report})

        {:noreply,
         socket
         |> put_flash(:info, "Report updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_report(socket, :new, report_params) do
    case Hub.create_report(report_params) do
      {:ok, report} ->
        notify_parent({:saved, report})

        {:noreply,
         socket
         |> put_flash(:info, "Report created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end

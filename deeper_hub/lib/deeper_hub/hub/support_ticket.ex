defmodule DeeperHub.Hub.SupportTicket do
  use Ecto.Schema
  import Ecto.Changeset

  schema "support_tickets" do
    field :status, :string
    field :issue_description, :string
    field :user_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(support_ticket, attrs) do
    support_ticket
    |> cast(attrs, [:issue_description, :status])
    |> validate_required([:issue_description, :status])
  end
end

defmodule DeeperHub.Hub.Report do
  use Ecto.Schema
  import Ecto.Changeset

  schema "reports" do
    field :report_type, :string
    field :report_details, :string
    field :reported_at, :utc_datetime
    field :reporter_id, :id
    field :reported_user_id, :id
    field :reported_server_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(report, attrs) do
    report
    |> cast(attrs, [:report_type, :report_details, :reported_at])
    |> validate_required([:report_type, :report_details, :reported_at])
  end
end

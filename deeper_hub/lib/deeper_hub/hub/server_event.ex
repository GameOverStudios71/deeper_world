defmodule DeeperHub.Hub.ServerEvent do
  use Ecto.Schema
  import Ecto.Changeset

  schema "events" do
    field :description, :string
    field :title, :string
    field :start_time, :utc_datetime
    field :end_time, :utc_datetime
    field :is_active, :boolean, default: false
    field :server_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(server_event, attrs) do
    server_event
    |> cast(attrs, [:title, :description, :start_time, :end_time, :is_active])
    |> validate_required([:title, :description, :start_time, :end_time, :is_active])
  end
end

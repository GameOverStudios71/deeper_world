defmodule DeeperHub.Hub.ServerUpdateMessage do
  use Ecto.Schema
  import Ecto.Changeset

  schema "server_update_messages" do
    field :update_notes, :string
    field :new_version, :string
    field :screenshoots, :string
    field :update_date, :utc_datetime
    field :server_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(server_update_message, attrs) do
    server_update_message
    |> cast(attrs, [:update_notes, :new_version, :screenshoots, :update_date])
    |> validate_required([:update_notes, :new_version, :screenshoots, :update_date])
  end
end

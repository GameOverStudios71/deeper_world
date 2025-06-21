defmodule DeeperHub.Hub.ServerReputation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "server_reputation" do
    field :reputation_score, :integer
    field :last_updated, :utc_datetime
    field :server_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(server_reputation, attrs) do
    server_reputation
    |> cast(attrs, [:reputation_score, :last_updated])
    |> validate_required([:reputation_score, :last_updated])
  end
end

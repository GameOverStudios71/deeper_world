defmodule DeeperHub.Hub.Engine do
  use Ecto.Schema
  import Ecto.Changeset

  schema "engines" do
    field :name, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(engine, attrs) do
    engine
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end

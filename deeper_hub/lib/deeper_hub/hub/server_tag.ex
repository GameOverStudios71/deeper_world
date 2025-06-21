defmodule DeeperHub.Hub.ServerTag do
  use Ecto.Schema
  import Ecto.Changeset

  schema "server_tags" do
    field :tag, :string
    field :server_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(server_tag, attrs) do
    server_tag
    |> cast(attrs, [:tag])
    |> validate_required([:tag])
  end
end

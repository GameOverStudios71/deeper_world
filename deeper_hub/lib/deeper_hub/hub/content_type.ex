defmodule DeeperHub.Hub.ContentType do
  use Ecto.Schema
  import Ecto.Changeset

  schema "content_types" do
    field :name, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(content_type, attrs) do
    content_type
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end

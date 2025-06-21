defmodule DeeperHub.Hub.Rating do
  use Ecto.Schema
  import Ecto.Changeset

  schema "ratings" do
    field :rating, :integer
    field :review_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(rating, attrs) do
    rating
    |> cast(attrs, [:rating])
    |> validate_required([:rating])
  end
end

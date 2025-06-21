defmodule DeeperHub.Hub.ServerReview do
  use Ecto.Schema
  import Ecto.Changeset

  schema "reviews" do
    field :comments, :string
    field :rating, :integer
    field :server_id, :id
    field :user_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(server_review, attrs) do
    server_review
    |> cast(attrs, [:rating, :comments])
    |> validate_required([:rating, :comments])
  end
end

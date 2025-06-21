defmodule DeeperHub.Hub.UserRecommendation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_recommendations" do
    field :recommendation_score, :float
    field :user_id, :id
    field :recommended_server_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user_recommendation, attrs) do
    user_recommendation
    |> cast(attrs, [:recommendation_score])
    |> validate_required([:recommendation_score])
  end
end

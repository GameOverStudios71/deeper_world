defmodule DeeperHub.Hub.Challenge do
  use Ecto.Schema
  import Ecto.Changeset

  schema "challenges" do
    field :challenge_name, :string
    field :challenge_description, :string
    field :points_reward, :integer
    field :start_date, :utc_datetime
    field :end_date, :utc_datetime

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(challenge, attrs) do
    challenge
    |> cast(attrs, [:challenge_name, :challenge_description, :points_reward, :start_date, :end_date])
    |> validate_required([:challenge_name, :challenge_description, :points_reward, :start_date, :end_date])
  end
end

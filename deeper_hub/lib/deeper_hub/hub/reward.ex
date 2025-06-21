defmodule DeeperHub.Hub.Reward do
  use Ecto.Schema
  import Ecto.Changeset

  schema "rewards" do
    field :reward_name, :string
    field :reward_description, :string
    field :points_required, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(reward, attrs) do
    reward
    |> cast(attrs, [:reward_name, :reward_description, :points_required])
    |> validate_required([:reward_name, :reward_description, :points_required])
  end
end

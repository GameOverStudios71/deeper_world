defmodule DeeperHub.Hub.AchievementType do
  use Ecto.Schema
  import Ecto.Changeset

  schema "achievement_types" do
    field :name, :string
    field :description, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(achievement_type, attrs) do
    achievement_type
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end

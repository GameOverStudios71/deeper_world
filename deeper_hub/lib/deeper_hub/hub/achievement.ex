defmodule DeeperHub.Hub.Achievement do
  use Ecto.Schema
  import Ecto.Changeset

  schema "achievements" do
    field :name, :string
    field :description, :string
    field :points, :integer
    field :icon, :string
    field :achievement_type_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(achievement, attrs) do
    achievement
    |> cast(attrs, [:name, :description, :points, :icon])
    |> validate_required([:name, :description, :points, :icon])
  end
end

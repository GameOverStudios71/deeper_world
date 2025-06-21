defmodule DeeperHub.Repo.Migrations.CreateAchievementTypes do
  use Ecto.Migration

  def change do
    create table(:achievement_types) do
      add :name, :string
      add :description, :text

      timestamps(type: :utc_datetime)
    end
  end
end

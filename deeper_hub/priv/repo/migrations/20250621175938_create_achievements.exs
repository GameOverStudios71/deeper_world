defmodule DeeperHub.Repo.Migrations.CreateAchievements do
  use Ecto.Migration

  def change do
    create table(:achievements) do
      add :name, :string
      add :description, :text
      add :points, :integer
      add :icon, :string
      add :achievement_type_id, references(:achievement_types, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:achievements, [:achievement_type_id])
  end
end

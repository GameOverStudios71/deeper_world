defmodule DeeperHub.Repo.Migrations.CreateEngines do
  use Ecto.Migration

  def change do
    create table(:engines) do
      add :name, :string

      timestamps(type: :utc_datetime)
    end
  end
end

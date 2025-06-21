defmodule DeeperHub.Repo.Migrations.CreateContentTypes do
  use Ecto.Migration

  def change do
    create table(:content_types) do
      add :name, :string

      timestamps(type: :utc_datetime)
    end
  end
end

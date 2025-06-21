defmodule DeeperHub.Repo.Migrations.CreateServerTags do
  use Ecto.Migration

  def change do
    create table(:server_tags) do
      add :tag, :string
      add :server_id, references(:servers, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:server_tags, [:server_id])
  end
end

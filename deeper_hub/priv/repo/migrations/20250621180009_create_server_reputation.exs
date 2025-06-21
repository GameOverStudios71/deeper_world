defmodule DeeperHub.Repo.Migrations.CreateServerReputation do
  use Ecto.Migration

  def change do
    create table(:server_reputation) do
      add :reputation_score, :integer
      add :last_updated, :utc_datetime
      add :server_id, references(:servers, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:server_reputation, [:server_id])
  end
end

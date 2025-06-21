defmodule DeeperHub.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :title, :string
      add :description, :text
      add :start_time, :utc_datetime
      add :end_time, :utc_datetime
      add :is_active, :boolean, default: false, null: false
      add :server_id, references(:servers, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:events, [:server_id])
  end
end

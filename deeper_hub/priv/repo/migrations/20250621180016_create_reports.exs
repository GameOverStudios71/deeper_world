defmodule DeeperHub.Repo.Migrations.CreateReports do
  use Ecto.Migration

  def change do
    create table(:reports) do
      add :report_type, :string
      add :report_details, :text
      add :reported_at, :utc_datetime
      add :reporter_id, references(:users, on_delete: :nothing)
      add :reported_user_id, references(:users, on_delete: :nothing)
      add :reported_server_id, references(:servers, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:reports, [:reporter_id])
    create index(:reports, [:reported_user_id])
    create index(:reports, [:reported_server_id])
  end
end

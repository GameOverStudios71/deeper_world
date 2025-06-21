defmodule DeeperHub.Repo.Migrations.CreateServerUpdateMessages do
  use Ecto.Migration

  def change do
    create table(:server_update_messages) do
      add :update_notes, :text
      add :new_version, :string
      add :screenshoots, :text
      add :update_date, :utc_datetime
      add :server_id, references(:servers, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:server_update_messages, [:server_id])
  end
end

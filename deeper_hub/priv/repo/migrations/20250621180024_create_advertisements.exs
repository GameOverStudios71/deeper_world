defmodule DeeperHub.Repo.Migrations.CreateAdvertisements do
  use Ecto.Migration

  def change do
    create table(:advertisements) do
      add :ad_title, :string
      add :ad_description, :text
      add :start_date, :utc_datetime
      add :end_date, :utc_datetime
      add :server_id, references(:servers, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:advertisements, [:server_id])
  end
end

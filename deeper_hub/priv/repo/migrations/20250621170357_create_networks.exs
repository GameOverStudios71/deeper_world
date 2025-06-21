defmodule DeeperHub.Repo.Migrations.CreateNetworks do
  use Ecto.Migration

  def change do
    create table(:networks) do
      add :name, :string

      timestamps(type: :utc_datetime)
    end
  end
end

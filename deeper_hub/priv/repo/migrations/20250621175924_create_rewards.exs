defmodule DeeperHub.Repo.Migrations.CreateRewards do
  use Ecto.Migration

  def change do
    create table(:rewards) do
      add :reward_name, :string
      add :reward_description, :text
      add :points_required, :integer

      timestamps(type: :utc_datetime)
    end
  end
end

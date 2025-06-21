defmodule DeeperHub.Repo.Migrations.CreateChallenges do
  use Ecto.Migration

  def change do
    create table(:challenges) do
      add :challenge_name, :string
      add :challenge_description, :text
      add :points_reward, :integer
      add :start_date, :utc_datetime
      add :end_date, :utc_datetime

      timestamps(type: :utc_datetime)
    end
  end
end

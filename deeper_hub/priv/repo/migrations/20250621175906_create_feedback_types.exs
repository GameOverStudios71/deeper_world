defmodule DeeperHub.Repo.Migrations.CreateFeedbackTypes do
  use Ecto.Migration

  def change do
    create table(:feedback_types) do
      add :name, :string
      add :description, :text

      timestamps(type: :utc_datetime)
    end
  end
end

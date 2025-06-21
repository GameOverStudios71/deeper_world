defmodule DeeperHub.Repo.Migrations.CreateUserFeedback do
  use Ecto.Migration

  def change do
    create table(:user_feedback) do
      add :feedback_text, :text
      add :submitted_at, :utc_datetime
      add :user_id, references(:users, on_delete: :nothing)
      add :feedback_id, references(:feedback_types, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:user_feedback, [:user_id])
    create index(:user_feedback, [:feedback_id])
  end
end

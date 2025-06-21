defmodule DeeperHub.Repo.Migrations.CreateSupportTickets do
  use Ecto.Migration

  def change do
    create table(:support_tickets) do
      add :issue_description, :text
      add :status, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:support_tickets, [:user_id])
  end
end

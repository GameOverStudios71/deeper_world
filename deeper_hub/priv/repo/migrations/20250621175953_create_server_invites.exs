defmodule DeeperHub.Repo.Migrations.CreateServerInvites do
  use Ecto.Migration

  def change do
    create table(:server_invites) do
      add :invite_code, :string
      add :expires_at, :utc_datetime
      add :server_id, references(:servers, on_delete: :nothing)
      add :inviter_id, references(:users, on_delete: :nothing)
      add :invitee_id, references(:users, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:server_invites, [:server_id])
    create index(:server_invites, [:inviter_id])
    create index(:server_invites, [:invitee_id])
  end
end

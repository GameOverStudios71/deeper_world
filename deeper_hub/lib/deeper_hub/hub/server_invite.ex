defmodule DeeperHub.Hub.ServerInvite do
  use Ecto.Schema
  import Ecto.Changeset

  schema "server_invites" do
    field :invite_code, :string
    field :expires_at, :utc_datetime
    field :server_id, :id
    field :inviter_id, :id
    field :invitee_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(server_invite, attrs) do
    server_invite
    |> cast(attrs, [:invite_code, :expires_at])
    |> validate_required([:invite_code, :expires_at])
  end
end

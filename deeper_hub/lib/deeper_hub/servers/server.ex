defmodule DeeperHub.Servers.Server do
  use Ecto.Schema
  import Ecto.Changeset

  schema "servers" do
    field :picture_box, :string
    field :picture_icon, :string
    field :picture_featured, :string
    field :picture_mini, :string
    field :screenshoots, :string
    field :feature_colors, :string
    field :network_id, :integer
    field :engine_id, :integer
    field :platform_version, :string
    field :allow_anonymous, :boolean
    field :max_connections, :integer
    field :encryption_level, :string
    field :created_at, :naive_datetime
  end

  @doc false
  def changeset(server, attrs) do
    server
    |> cast(attrs, [:picture_box, :picture_icon, :picture_featured, :platform_version, :encryption_level])
    |> validate_required([:picture_box, :picture_icon, :platform_version])
    |> validate_length(:picture_box, max: 255)
    |> validate_length(:picture_icon, max: 255)
    |> validate_length(:picture_featured, max: 255)
    |> validate_length(:feature_colors, max: 100)
    |> validate_length(:platform_version, max: 50)
    |> validate_length(:encryption_level, max: 20)
  end
end

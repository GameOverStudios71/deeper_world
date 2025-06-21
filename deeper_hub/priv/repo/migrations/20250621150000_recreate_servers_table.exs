defmodule DeeperHub.Repo.Migrations.RecreateServersTable do
  use Ecto.Migration

  def change do
    create table(:servers) do
      add :picture_box, :string
      add :picture_icon, :string
      add :picture_featured, :string
      add :picture_mini, :string
      add :screenshoots, :text
      add :feature_colors, :string
      add :network_id, :integer
      add :engine_id, :integer
      add :platform_version, :string
      add :allow_anonymous, :boolean
      add :max_connections, :integer
      add :encryption_level, :string
      add :created_at, :naive_datetime
    end
  end
end

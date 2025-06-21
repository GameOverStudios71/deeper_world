defmodule DeeperHub.Repo.Migrations.CreateServers do
  use Ecto.Migration

  def change do
    create table(:servers) do
      add :verified, :boolean, default: false, null: false
      add :latitude, :float
      add :longitude, :float
      add :country, :string
      add :region, :string
      add :city, :string
      add :server_name, :string
      add :url, :string
      add :description_hero, :string
      add :description_full, :text
      add :ping_ms, :integer
      add :visited_users_lst_mounth, :integer
      add :reputation, :integer
      add :ai_permission, :boolean, default: false, null: false
      add :ai_generated, :boolean, default: false, null: false
      add :server_rules, :text
      add :server_cpu_info, :string
      add :server_max_users, :integer
      add :min_age, :integer
      add :picture_box, :text
      add :picture_icon, :text
      add :picture_featured, :text
      add :picture_mini, :text
      add :screenshoots, :text
      add :feature_colors, :text
      add :platform_version, :text
      add :allow_anonymous, :boolean, default: false, null: false
      add :max_connections, :integer
      add :encryption_level, :text
      add :owner_id, references(:users, on_delete: :nothing)
      add :content_type_id, references(:content_types, on_delete: :nothing)
      add :network_id, references(:networks, on_delete: :nothing)
      add :engine_id, references(:engines, on_delete: :nothing)
      add :status_id, references(:statuses, on_delete: :nothing)
      add :category_id, references(:categories, on_delete: :nothing)
      add :language_id, references(:languages, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:servers, [:owner_id])
    create index(:servers, [:content_type_id])
    create index(:servers, [:network_id])
    create index(:servers, [:engine_id])
    create index(:servers, [:status_id])
    create index(:servers, [:category_id])
    create index(:servers, [:language_id])
  end
end

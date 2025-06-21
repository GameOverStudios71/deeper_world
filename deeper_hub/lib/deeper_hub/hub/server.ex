defmodule DeeperHub.Hub.Server do
  use Ecto.Schema
  import Ecto.Changeset

  schema "servers" do
    field :server_name, :string
    field :url, :string
    field :verified, :boolean, default: false
    field :latitude, :float
    field :longitude, :float
    field :country, :string
    field :region, :string
    field :city, :string
    field :description_hero, :string
    field :description_full, :string
    field :ping_ms, :integer
    field :visited_users_lst_mounth, :integer
    field :reputation, :integer
    field :ai_permission, :boolean, default: false
    field :ai_generated, :boolean, default: false
    field :server_rules, :string
    field :server_cpu_info, :string
    field :server_max_users, :integer
    field :min_age, :integer
    field :picture_box, :string
    field :picture_icon, :string
    field :picture_featured, :string
    field :picture_mini, :string
    field :screenshoots, :string
    field :feature_colors, :string
    field :platform_version, :string
    field :allow_anonymous, :boolean, default: false
    field :max_connections, :integer
    field :encryption_level, :string
    belongs_to :owner, DeeperHub.Accounts.User, foreign_key: :owner_id
    belongs_to :content_type, DeeperHub.Hub.ContentType
    belongs_to :network, DeeperHub.Hub.Network
    belongs_to :engine, DeeperHub.Hub.Engine
    belongs_to :status, DeeperHub.Hub.Status
    belongs_to :category, DeeperHub.Hub.Category
    belongs_to :language, DeeperHub.Hub.Language

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(server, attrs) do
    server
    |> cast(attrs, [
      :verified,
      :latitude,
      :longitude,
      :country,
      :region,
      :city,
      :server_name,
      :url,
      :description_hero,
      :description_full,
      :ping_ms,
      :visited_users_lst_mounth,
      :reputation,
      :ai_permission,
      :ai_generated,
      :server_rules,
      :server_cpu_info,
      :server_max_users,
      :min_age,
      :picture_box,
      :picture_icon,
      :picture_featured,
      :picture_mini,
      :screenshoots,
      :feature_colors,
      :platform_version,
      :allow_anonymous,
      :max_connections,
      :encryption_level,
      :owner_id,
      :content_type_id,
      :network_id,
      :engine_id,
      :status_id,
      :category_id,
      :language_id
    ])
    |> validate_required([
      :verified,
      :latitude,
      :longitude,
      :country,
      :region,
      :city,
      :server_name,
      :url,
      :description_hero,
      :description_full,
      :ping_ms,
      :visited_users_lst_mounth,
      :reputation,
      :ai_permission,
      :ai_generated,
      :server_rules,
      :server_cpu_info,
      :server_max_users,
      :min_age,
      :picture_box,
      :picture_icon,
      :picture_featured,
      :picture_mini,
      :screenshoots,
      :feature_colors,
      :platform_version,
      :allow_anonymous,
      :max_connections,
      :encryption_level,
      :owner_id,
      :content_type_id,
      :network_id,
      :engine_id,
      :status_id,
      :category_id,
      :language_id
    ])
    |> foreign_key_constraint(:owner_id)
    |> foreign_key_constraint(:content_type_id)
    |> foreign_key_constraint(:network_id)
    |> foreign_key_constraint(:engine_id)
    |> foreign_key_constraint(:status_id)
    |> foreign_key_constraint(:category_id)
    |> foreign_key_constraint(:language_id)
  end
end

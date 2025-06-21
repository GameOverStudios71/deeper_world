defmodule DeeperHub.Repo.Migrations.CreateUserRecommendations do
  use Ecto.Migration

  def change do
    create table(:user_recommendations) do
      add :recommendation_score, :float
      add :user_id, references(:users, on_delete: :nothing)
      add :recommended_server_id, references(:servers, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:user_recommendations, [:user_id])
    create index(:user_recommendations, [:recommended_server_id])
  end
end

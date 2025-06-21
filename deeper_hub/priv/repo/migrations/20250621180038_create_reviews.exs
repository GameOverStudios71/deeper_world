defmodule DeeperHub.Repo.Migrations.CreateReviews do
  use Ecto.Migration

  def change do
    create table(:reviews) do
      add :rating, :integer
      add :comments, :text
      add :server_id, references(:servers, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:reviews, [:server_id])
    create index(:reviews, [:user_id])
  end
end

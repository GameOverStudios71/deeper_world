defmodule DeeperHub.Repo.Migrations.CreateRatings do
  use Ecto.Migration

  def change do
    create table(:ratings) do
      add :rating, :integer
      add :review_id, references(:reviews, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:ratings, [:review_id])
  end
end

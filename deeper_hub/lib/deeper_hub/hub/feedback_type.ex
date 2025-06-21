defmodule DeeperHub.Hub.FeedbackType do
  use Ecto.Schema
  import Ecto.Changeset

  schema "feedback_types" do
    field :name, :string
    field :description, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(feedback_type, attrs) do
    feedback_type
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end

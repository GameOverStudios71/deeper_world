defmodule DeeperHub.Hub.UserFeedback do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_feedback" do
    field :feedback_text, :string
    field :submitted_at, :utc_datetime
    field :user_id, :id
    field :feedback_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user_feedback, attrs) do
    user_feedback
    |> cast(attrs, [:feedback_text, :submitted_at])
    |> validate_required([:feedback_text, :submitted_at])
  end
end

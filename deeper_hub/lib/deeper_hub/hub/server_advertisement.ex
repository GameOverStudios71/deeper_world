defmodule DeeperHub.Hub.ServerAdvertisement do
  use Ecto.Schema
  import Ecto.Changeset

  schema "advertisements" do
    field :ad_title, :string
    field :ad_description, :string
    field :start_date, :utc_datetime
    field :end_date, :utc_datetime
    field :server_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(server_advertisement, attrs) do
    server_advertisement
    |> cast(attrs, [:ad_title, :ad_description, :start_date, :end_date])
    |> validate_required([:ad_title, :ad_description, :start_date, :end_date])
  end
end

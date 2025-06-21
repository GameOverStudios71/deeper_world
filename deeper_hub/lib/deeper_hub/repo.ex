defmodule DeeperHub.Repo do
  use Ecto.Repo,
    otp_app: :deeper_hub,
    adapter: Ecto.Adapters.SQLite3
end

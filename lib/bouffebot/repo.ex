defmodule Bouffebot.Repo do
  use Ecto.Repo,
    otp_app: :bouffebot,
    adapter: Ecto.Adapters.Postgres
end

defmodule Tapii.Repo do
  use Ecto.Repo,
    otp_app: :tapii,
    adapter: Ecto.Adapters.Postgres
end

defmodule Noticias.Repo do
  use Ecto.Repo,
    otp_app: :noticias,
    adapter: Ecto.Adapters.Postgres
end

defmodule DietPro.Repo do
  use Ecto.Repo,
    otp_app: :diet_pro,
    adapter: Ecto.Adapters.Postgres
end

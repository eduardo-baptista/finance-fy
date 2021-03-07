defmodule FinanceFy.Repo do
  use Ecto.Repo,
    otp_app: :finance_fy,
    adapter: Ecto.Adapters.Postgres
end

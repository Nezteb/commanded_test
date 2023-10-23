defmodule CommandedTest.Repo do
  use Ecto.Repo,
    otp_app: :commanded_test,
    adapter: Ecto.Adapters.Postgres
end

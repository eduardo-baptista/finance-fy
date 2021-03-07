# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :finance_fy,
  ecto_repos: [FinanceFy.Repo]

# Configures the endpoint
config :finance_fy, FinanceFyWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "RmoD/b20t0ZlZfYCBXwI9bW85uImDQYNHCciNxZUbhDRcJd1gZDhUkUB/QNxUHGs",
  render_errors: [view: FinanceFyWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: FinanceFy.PubSub,
  live_view: [signing_salt: "29fBjf3y"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

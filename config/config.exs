# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :poster,
  ecto_repos: [Poster.Repo]

# Configures the endpoint
config :poster, Poster.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "HcR9Dj9YQcKEa3PV4z0HDg+peQmAg6cG+yARl3JwWJMrt6yCUU0QXfEMUGhvrnB6",
  render_errors: [view: Poster.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Poster.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Number Configuration
config :number, currency: [
                  unit: "KES",
                  precision: 2,
                  delimiter: ",",
                  separator: ".",
                  format: "%u %n",           # "KES 30.00"
                  negative_format: "(%u %n)" # "(KES 30.00)"
                ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

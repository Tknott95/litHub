# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :litHub,
  ecto_repos: [LitHub.Repo]

# Configures the endpoint
config :litHub, LitHub.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "n3+iTdjMLr6cRmzhBMIONRAVhQh++SbF5+M7PaZc2mTIAkWcqwJ2AA8paoAs6nUV",
  render_errors: [view: LitHub.ErrorView, accepts: ~w(html json)],
  pubsub: [name: LitHub.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

config :ueberauth, Ueberauth,
  providers: [
    github: { Ueberauth.Strategy.Github, [] }
  ]

config :ueberauth, Ueberauth.Strategy.Github.OAuth,
  client_id: "b22f9cc64c3711c492f1",
  client_secret: "f5065a7d6aa9977aef3406e5673dc02b4a16f59f"
  
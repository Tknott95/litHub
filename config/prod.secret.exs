use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or you later on).
# Configure your database
config :litHub, LitHub.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "lithub_prod",
  pool_size: 20

config :ueberauth, Ueberauth.Strategy.Github.OAuth,
  client_id: "b22f9cc64c3711c492f1",
  client_secret: "f5065a7d6aa9977aef3406e5673dc02b4a16f59f"

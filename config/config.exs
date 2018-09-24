# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :partidoService,
  ecto_repos: [PartidoService.Repo]

# Configures the endpoint
config :partidoService, PartidoServiceWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "NqSZmXaEncF7+Dq3fQkFQmenh5+Lmc5v5owgBbmUavW2JuvA790Yn4n92oThQG/c",
  render_errors: [view: PartidoServiceWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: PartidoService.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

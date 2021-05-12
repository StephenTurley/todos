import Config
config :tesla, :adapter, Tesla.Adapter.Hackney
config :server, :ecto_repos, [Server.Boundary.TaskRepo]

config :server, Server.Boundary.TaskRepo,
  database: "todos",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  port: 5434

import_config "#{config_env()}.exs"

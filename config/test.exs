import Config
config :tesla, adapter: Tesla.Mock

config :server, Server.Boundary.TaskRepo,
  database: "todos_test",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  port: 5434,
  pool: Ecto.Adapters.SQL.Sandbox

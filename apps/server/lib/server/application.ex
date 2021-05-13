defmodule Server.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Server.Boundary.TaskRepo, name: Server.Boundary.TaskRepo},
      {Server.Boundary.TaskManager, name: Server.Boundary.TaskManager},
      {Plug.Cowboy, scheme: :http, plug: Router, options: [port: 4001]}
    ]

    opts = [strategy: :one_for_one, name: Server.Supervisor]

    Supervisor.start_link(children, opts)
  end
end

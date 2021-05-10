defmodule Td.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Boundary.TaskManager, name: Boundary.TaskManager}
    ]

    opts = [strategy: :one_for_one, name: Td.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

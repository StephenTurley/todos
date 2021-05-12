defmodule Server.RepoCase do
  use ExUnit.CaseTemplate
  alias Server.Boundary.TaskRepo

  using do
    quote do
      alias Server.Boundary.TaskRepo

      import Ecto
      import Ecto.Query
      import Server.RepoCase
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(TaskRepo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(TaskRepo, {:shared, self()})
    end

    :ok
  end
end

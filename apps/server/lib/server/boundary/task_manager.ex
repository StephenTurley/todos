defmodule Server.Boundary.TaskManager do
  use Agent

  def start_link(_) do
    Agent.start_link(fn -> [] end, name: __MODULE__)
  end

  def all(manager) do
    Agent.get(manager, &Function.identity/1)
  end

  def add(manager, task) do
    Agent.update(manager, fn list -> [task | list] end)
  end
end

defmodule Server.Boundary.TaskManager do
  use Agent
  alias Core.TaskList

  def start_link(_) do
    Agent.start_link(&TaskList.new/0, name: __MODULE__)
  end

  def all(manager \\ __MODULE__) do
    Agent.get(manager, &Function.identity/1)
  end

  def add(manager \\ __MODULE__, task) do
    Agent.update(manager, fn list -> TaskList.add(list, task) end)
  end

  def clear(manager \\ __MODULE__) do
    Agent.update(manager, fn _ -> [] end)
  end
end

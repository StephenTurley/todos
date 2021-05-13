defmodule Server.Boundary.TaskManager do
  use Agent
  alias Core.TaskList

  def start_link(_) do
    Agent.start_link(&TaskList.new/0, name: __MODULE__)
  end

  def all() do
    Agent.get(__MODULE__, &Function.identity/1)
  end

  def all(provider) do
    Agent.update(__MODULE__, provider)
    all()
  end

  def add(task) do
    Agent.update(__MODULE__, fn list -> TaskList.add(list, task) end)
  end

  def add(task, persister) do
    with {:ok, t} <- persister.(task), do: add(t)
  end

  def clear() do
    Agent.update(__MODULE__, fn _ -> [] end)
  end
end

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
    Agent.update(__MODULE__, fn _ -> provider.() end)
    all()
  end

  def add(task) do
    Agent.update(__MODULE__, fn list -> TaskList.add(list, task) end)
  end

  def add(task, persister) do
    persister.(task) |> IO.inspect() |> add
  end

  def clear() do
    Agent.update(__MODULE__, fn _ -> [] end)
  end

  def clear(persister) do
    with :ok <- persister.(), do: clear()
  end
end

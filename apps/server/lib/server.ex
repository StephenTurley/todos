defmodule Server do
  alias Server.Boundary.TaskManager
  alias Server.Core.Task

  def all() do
    {:ok, tasks: TaskManager.all()}
  end

  def add_task() do
    {:error, "you must include a title"}
  end

  def add_task(title: title) do
    TaskManager.add(Task.new(title: title))
    :ok
  end
end

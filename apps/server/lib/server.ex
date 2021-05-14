defmodule Server do
  alias Server.Boundary.TaskManager
  alias Server.Boundary.TaskPersistence, as: DB
  alias Core.Boundary.TaskValidator
  alias Core.Task

  def all() do
    tasks = TaskManager.all(&DB.all/0)
    {:ok, tasks}
  end

  def add_task(fields) do
    with :ok <- TaskValidator.errors(fields),
         task <- Task.new(fields),
         :ok <- TaskManager.add(task, &DB.add/1) do
      {:ok, task}
    else
      errors -> errors
    end
  end

  def complete_task(_title) do
    :ok
  end
end

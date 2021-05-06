defmodule Server do
  alias Server.Boundary.TaskManager
  alias Server.Boundary.TaskValidator
  alias Server.Core.Task

  def all() do
    {:ok, TaskManager.all()}
  end

  def add_task(fields) do
    with :ok <- TaskValidator.errors(fields),
         task <- Task.new(fields),
         :ok <- TaskManager.add(task) do
      :ok
    else
      errors -> errors
    end
  end
end

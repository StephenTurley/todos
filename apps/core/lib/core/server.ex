defmodule Core.Server do
  alias Boundary.TaskManager
  alias Core.Boundary.TaskValidator
  alias Core.Task

  def all() do
    {:ok, TaskManager.all()}
  end

  def add_task(fields) do
    with :ok <- TaskValidator.errors(fields),
         task <- Task.new(fields),
         :ok <- TaskManager.add(task) do
      {:ok, task}
    else
      errors -> errors
    end
  end
end

defmodule Server do
  alias Server.Boundary.TaskPersistence, as: DB
  alias Core.Boundary.TaskValidator
  alias Core.Task

  def all() do
    tasks = DB.all()
    {:ok, tasks}
  end

  def add_task(fields) do
    with :ok <- TaskValidator.errors(fields),
         task <- Task.new(fields),
         added <- DB.add(task) do
      {:ok, added}
    else
      errors -> errors
    end
  end

  def complete_task(title) do
    DB.find_by(title: title)
    |> Task.complete()
    |> DB.update_is_complete()
  end
end

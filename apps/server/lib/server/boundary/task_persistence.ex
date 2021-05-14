defmodule Server.Boundary.TaskPersistence do
  import Ecto.Query
  alias Server.Boundary.TaskRepo
  alias Server.Core.TaskSchema
  alias Core.Task
  alias Core.TaskList

  def add(task) do
    TaskSchema.add_new_changeset(task)
    |> TaskRepo.insert!()
    |> to_task()
  end

  def all() do
    from(
      t in TaskSchema,
      select: %{id: t.id, title: t.title, is_complete: t.is_complete}
    )
    |> TaskRepo.all()
    |> Enum.map(&to_task/1)
    |> TaskList.new()
  end

  def clear() do
    TaskRepo.delete_all(TaskSchema)
    :ok
  end

  def find_by(title: title) do
    TaskRepo.get_by!(TaskSchema, title: title)
    |> to_task
  end

  def update_is_complete(task) do
    TaskRepo.get!(TaskSchema, task.id)
    |> TaskSchema.change_is_complete(task.is_complete)
    |> TaskRepo.update!()
    |> to_task()
  end

  defp to_task(t) do
    Task.new(
      title: t.title,
      id: t.id,
      is_complete: t.is_complete
    )
  end
end

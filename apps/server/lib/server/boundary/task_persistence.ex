defmodule Server.Boundary.TaskPersistence do
  import Ecto.Query
  alias Server.Boundary.TaskRepo
  alias Server.Core.TaskSchema
  alias Core.Task

  def add(task) do
    TaskSchema.add_new_changeset(task)
    |> TaskRepo.insert!()
    |> to_task()
  end

  def all() do
    from(
      t in TaskSchema,
      select: %{id: t.id, title: t.title}
    )
    |> TaskRepo.all()
    |> Enum.map(&to_task/1)
  end

  defp to_task(%{id: id, title: title}) do
    Task.new(
      title: title,
      id: id
    )
  end
end

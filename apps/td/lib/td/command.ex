defmodule TD.Boundary.Command do
  alias Core.Server

  def process(["add", title]) do
    with {:ok, task} <- Server.add_task(%{title: title}) do
      {:ok, [task.title]}
    else
      errors -> {:error, errors}
    end
  end

  def process([]) do
    with {:ok, tasks} <- Server.all() do
      {:ok, Enum.map(tasks, fn t -> t.title end)}
    else
      errors -> {:error, errors}
    end
  end

  def process(_) do
    {:error, ["Invalid Command"]}
  end
end

defmodule TD.Boundary.Command do
  alias Core.Server
  alias Core.Task

  def process(["add", title]) do
    with {:ok, task} <- Server.add_task(%{title: title}) do
      {:ok, [Task.toString(task)]}
    else
      errors -> {:error, errors}
    end
  end

  def process([]) do
    with {:ok, tasks} <- Server.all() do
      {:ok, Enum.map(tasks, &Task.toString/1)}
    else
      errors -> {:error, errors}
    end
  end

  def process(_) do
    {:error, ["Invalid Command"]}
  end
end

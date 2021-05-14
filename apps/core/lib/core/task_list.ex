defmodule Core.TaskList do
  def new(list \\ []) do
    list
  end

  # TODO make titles unique
  def add(list, task) do
    list ++ [task]
  end

  def update_by(list, updater, title: title) do
    list
    |> Enum.map(fn
      %{title: ^title} = task -> updater.(task)
      t -> t
    end)
  end
end

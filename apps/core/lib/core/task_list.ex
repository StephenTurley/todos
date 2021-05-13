defmodule Core.TaskList do
  def new(list \\ []) do
    list
  end

  def add(list, task) do
    list ++ [task]
  end
end

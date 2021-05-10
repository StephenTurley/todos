defmodule Core.TaskList do
  def new() do
    []
  end

  def add(list, task) do
    list ++ [task]
  end
end

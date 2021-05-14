defmodule Server.Core.TaskListTest do
  use ExUnit.Case, async: true

  alias Core.Task
  alias Core.TaskList

  test "you can add tasks" do
    result =
      TaskList.new()
      |> TaskList.add(Task.new(title: "flerpn"))
      |> TaskList.add(Task.new(title: "derpn"))

    assert result == [Task.new(title: "flerpn"), Task.new(title: "derpn")]
  end
end

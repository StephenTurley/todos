defmodule Server.Core.TaskListTest do
  use ExUnit.Case, async: true

  alias Server.Core.Task
  alias Server.Core.TaskList

  test "you can add tasks" do
    result =
      TaskList.new()
      |> TaskList.add(Task.new(title: "flerpn"))
      |> TaskList.add(Task.new(title: "derpn"))

    assert result == [%Task{title: "flerpn"}, %Task{title: "derpn"}]
  end
end

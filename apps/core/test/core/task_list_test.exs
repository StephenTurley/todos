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

  test "update by title" do
    result =
      TaskList.new()
      |> TaskList.add(Task.new(id: 1, title: "flerpn", is_complete: false))
      |> TaskList.add(Task.new(id: 2, title: "derpn", is_complete: false))
      |> TaskList.update_by(&Task.complete/1, title: "derpn")

    assert result == [
             Task.new(id: 1, title: "flerpn", is_complete: false),
             Task.new(id: 2, title: "derpn", is_complete: true)
           ]
  end
end

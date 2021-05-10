defmodule Boundary.TaskManagerTest do
  use ExUnit.Case, async: true

  alias Server.Boundary.TaskManager
  alias Core.Task

  setup do
    task_manager = start_supervised!(TaskManager)
    %{task_manager: task_manager}
  end

  test "starts with empty list", %{task_manager: task_manager} do
    assert TaskManager.all(task_manager) == []
  end

  test "can add a new Task", %{task_manager: task_manager} do
    TaskManager.add(task_manager, Task.new(title: "Flerpn"))

    assert TaskManager.all(task_manager) == [
             %Task{title: "Flerpn"}
           ]
  end
end

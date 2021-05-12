defmodule Boundary.TaskManagerTest do
  use ExUnit.Case, async: true

  alias Boundary.TaskManager
  alias Core.Task

  setup do
    TaskManager.clear()
  end

  test "starts with empty list", %{task_manager: task_manager} do
    assert TaskManager.all() == []
  end

  test "can add a new Task", %{task_manager: task_manager} do
    TaskManager.add(Task.new(title: "Flerpn"))

    assert TaskManager.all() == [
             %Task{title: "Flerpn"}
           ]
  end
end

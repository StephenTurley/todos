defmodule Server.Boundary.TaskManagerTest do
  use ExUnit.Case, async: true

  alias Server.Boundary.TaskManager
  alias Core.Task

  setup do
    TaskManager.clear()
  end

  test "starts with empty list" do
    assert TaskManager.all() == []
  end

  test "can add a new Task" do
    TaskManager.add(Task.new(title: "Flerpn"))

    assert TaskManager.all() == [
             %Task{title: "Flerpn"}
           ]
  end
end

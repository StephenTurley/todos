defmodule Server.Boundary.TaskManagerTest do
  use ExUnit.Case, async: true

  alias Server.Boundary.TaskManager
  alias Core.Task

  setup do
    TaskManager.clear()
  end

  describe "all" do
    test "starts with empty list" do
      assert TaskManager.all() == []
    end

    test "can be called with an external provider" do
      tasks = [Task.new(title: "foo")]
      provider = fn _ -> tasks end

      result = TaskManager.all(provider)
      assert result == tasks

      still_there = TaskManager.all()
      assert still_there == tasks
    end
  end

  describe "add" do
    test "can add a new Task" do
      TaskManager.add(Task.new(title: "Flerpn"))

      assert TaskManager.all() == [
               %Task{title: "Flerpn"}
             ]
    end

    test "can persist the added task" do
      task = Task.new(title: "Flerpn")

      persister = fn t ->
        send(self(), t)
        {:ok, Task.new(title: "Flerpn Persisted")}
      end

      TaskManager.add(task, persister)

      assert_received(^task)

      assert TaskManager.all() == [
               %Task{title: "Flerpn Persisted"}
             ]
    end
  end
end

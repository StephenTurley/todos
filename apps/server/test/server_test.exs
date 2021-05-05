defmodule ServerTest do
  use ExUnit.Case
  alias Server.Boundary.TaskManager
  alias Server.Core.Task

  setup do
    start_supervised!(TaskManager)
    %{}
  end

  test "it starts the an agent" do
    assert {:ok, tasks: []} = Server.all()
  end

  test "you can add a task" do
    assert :ok = Server.add_task(title: "Foo")

    assert {:ok, tasks: [%Task{title: "Foo"}]} = Server.all()
  end

  describe "validations" do
    test "you must have a title" do
      assert {:error, "you must include a title"} = Server.add_task()
    end
  end
end

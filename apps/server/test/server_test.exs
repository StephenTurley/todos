defmodule ServerTest do
  use ExUnit.Case, async: false
  alias Server.Core.Task
  alias Server.Boundary.TaskManager

  setup do
    %{pid: start_supervised!(TaskManager)}
  end

  test "you can add a task" do
    assert :ok = Server.add_task(title: "Foo")

    assert {:ok, [%Task{title: "Foo"}]} = Server.all()
  end

  describe "validations" do
    test "you must have a title" do
      assert {:error, "you must include a title"} = Server.add_task()
    end
  end
end

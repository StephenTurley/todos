defmodule Core.ServerTest do
  use ExUnit.Case, async: false
  alias Core.Server
  alias Core.Task
  alias Boundary.TaskManager

  setup do
    %{pid: start_supervised!(TaskManager)}
  end

  test "you can add a task" do
    assert :ok = Server.add_task(%{title: "Foo"})

    assert {:ok, [%Task{title: "Foo"}]} = Server.all()
  end

  describe "validations" do
    test "you must have a title" do
      assert [{:error, "title is required"}] = Server.add_task(%{})
    end
  end
end

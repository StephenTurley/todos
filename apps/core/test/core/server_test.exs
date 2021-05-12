defmodule Core.ServerTest do
  use ExUnit.Case, async: false
  alias Core.Server
  alias Core.Task
  alias Boundary.TaskManager

  test "you can add a task" do
    assert {:ok, task} = Server.add_task(%{title: "Foo"})

    assert task == %Task{title: "Foo"}

    assert {:ok, [%Task{title: "Foo"}]} == Server.all()
  end

  describe "validations" do
    test "you must have a title" do
      assert ["title is required"] == Server.add_task(%{})
    end
  end
end

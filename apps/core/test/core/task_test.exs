defmodule Core.TaskTest do
  use ExUnit.Case, async: true
  alias Core.Task

  describe "building a Task" do
    test "should create a Task" do
      result = Task.new(title: "FooBar")
      assert result.title == "FooBar"
    end

    test "has optional id" do
      result = Task.new(id: 1, title: "FooBar")
      assert result.id == 1
    end

    test "turn into json" do
      task = Task.new(id: 1, title: "FooBar")

      result = Jason.encode!(task)

      assert result == ~s({"id":1,"title":"FooBar"})
    end

    test "should turn into a console message" do
      task = Task.new(title: "FooBar")

      result = Task.toString(task)

      assert result == "FooBar"
    end
  end
end

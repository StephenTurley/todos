defmodule Core.TaskTest do
  use ExUnit.Case, async: true
  alias Core.Task

  describe "building a Task" do
    test "should create a Task" do
      result = Task.new(title: "FooBar")
      assert result.title == "FooBar"
    end

    test "turn into json" do
      task = Task.new(title: "FooBar")

      result = Jason.encode!(task)

      assert result == ~s({"title":"FooBar"})
    end

    test "should turn into a console message" do
      task = Task.new(title: "FooBar")

      result = Task.toString(task)

      assert result == "FooBar"
    end
  end
end

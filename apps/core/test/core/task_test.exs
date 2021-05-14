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
  end

  describe "serialization" do
    test "turn into json" do
      task = Task.new(id: 1, title: "FooBar")

      result = Jason.encode!(task)

      assert result == ~s({"id":1,"title":"FooBar"})
    end
  end
end

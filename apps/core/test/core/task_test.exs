defmodule Core.TaskTest do
  use ExUnit.Case, async: true
  alias Core.Task

  describe "building a Task" do
    test "should create a Task" do
      result = Task.new(title: "FooBar")
      assert result.title == "FooBar"
    end
  end
end

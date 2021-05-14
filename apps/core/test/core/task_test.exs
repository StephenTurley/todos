defmodule Core.TaskTest do
  use ExUnit.Case, async: true
  alias Core.Task

  describe "building a Task" do
    test "should create a Task" do
      result = Task.new(title: "FooBar")
      assert result.title == "FooBar"
      assert result.is_complete == false
      assert result.id == nil
    end

    test "can build from map" do
      result = Task.new(%{title: "FooBar"})
      assert result.title == "FooBar"
      assert result.is_complete == false
      assert result.id == nil
    end

    test "has optional id" do
      id =
        Task.new(id: 1, title: "FooBar")
        |> Map.get(:id)

      assert id == 1
    end

    test "can set is_complete in constructor" do
      is_complete =
        Task.new(is_complete: true, id: 1, title: "FooBar")
        |> Map.get(:is_complete)

      assert is_complete == true
    end
  end

  describe "complete/1" do
    test "can complete" do
      is_complete =
        Task.new(is_complete: false, title: "FooBar")
        |> Task.complete()
        |> Map.get(:is_complete)

      assert is_complete == true
    end
  end

  describe "serialization" do
    test "turn into json" do
      json =
        Task.new(id: 1, title: "FooBar")
        |> Jason.encode!()

      assert json == ~s({"id":1,"title":"FooBar","is_complete":false})
    end
  end
end

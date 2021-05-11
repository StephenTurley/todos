defmodule TD.Core.CommandTest do
  use ExUnit.Case

  alias TD.Core.Command
  alias Core.Task

  describe "add" do
    test "builds the add command" do
      result = Command.parse(["add", "foo bar"])

      assert result == %Command{
               type: :add,
               body: %Task{title: "foo bar"},
               response: [],
               status: :ok
             }
    end

    test "it validates the task" do
      result = Command.parse(["add", ""])

      assert result == %Command{
               type: :add,
               body: %{},
               response: ["title must not be empty"],
               status: :error
             }
    end
  end

  describe "all" do
    test "it builds the all command" do
      result = Command.parse([])

      assert result == %Command{
               type: :all,
               body: %{},
               response: [],
               status: :ok
             }
    end
  end

  describe "invalid" do
    test "it builds the invalid command" do
      result = Command.parse(["not a thing"])

      assert result == %Command{
               type: :invalid,
               body: %{},
               response: ["invalid command"],
               status: :error
             }
    end
  end
end

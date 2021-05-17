defmodule TD.Core.CommandParserTest do
  use ExUnit.Case
  alias TD.Core.CommandParser
  alias TD.Core.Command
  alias Core.Task

  describe "parsing add commmand" do
    test "builds the add command" do
      result = CommandParser.parse(["--add", "foo bar"])

      assert result == %Command{
               type: :add,
               body: Task.new(title: "foo bar"),
               tasks: [],
               response: [],
               status: :ok
             }
    end

    test "it validates the task" do
      result = CommandParser.parse(["--add", ""])

      assert result == %Command{
               type: :add,
               body: %{},
               tasks: [],
               response: ["title must not be empty"],
               status: :error
             }
    end
  end

  describe "parsing empty args" do
    test "it builds the all command" do
      result = CommandParser.parse([])

      assert result == %Command{
               type: :all,
               body: %{},
               tasks: [],
               response: [],
               status: :ok
             }
    end
  end

  describe "parsing the complete command" do
    test "it builds the command" do
      result = CommandParser.parse(["-c", "the title"])

      assert result == %Command{
               type: :complete,
               body: "the title",
               tasks: [],
               response: [],
               status: :ok
             }
    end
  end

  describe "parsing an invalid commmand" do
    test "it builds the invalid command" do
      result = CommandParser.parse(["not a thing"])

      assert result.type == :invalid
      assert result.body == %{}
      assert result.tasks == []
      assert result.status == :error

      assert result.response == [
               "td [options] [args]",
               "td, Prints todo list",
               "-a, --add <title>, Add a task",
               "-c, --complete <title>, Complete a task"
             ]
    end
  end
end

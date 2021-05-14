defmodule TD.Core.CommandTest do
  use ExUnit.Case, async: true

  alias TD.Core.Command
  alias Core.Task

  describe "parsing add commmand" do
    test "builds the add command" do
      result = Command.parse(["add", "foo bar"])

      assert result == %Command{
               type: :add,
               body: Task.new(title: "foo bar"),
               tasks: [],
               response: [],
               status: :ok
             }
    end

    test "it validates the task" do
      result = Command.parse(["add", ""])

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
      result = Command.parse([])

      assert result == %Command{
               type: :all,
               body: %{},
               tasks: [],
               response: [],
               status: :ok
             }
    end
  end

  describe "parsing the done command" do
    test "it builds the command" do
      result = Command.parse(["done", "the title"])

      assert result == %Command{
               type: :done,
               body: "the title",
               tasks: [],
               response: [],
               status: :ok
             }
    end
  end

  describe "parsing an invalid commmand" do
    test "it builds the invalid command" do
      result = Command.parse(["not a thing"])

      assert result == %Command{
               type: :invalid,
               body: %{},
               tasks: [],
               response: ["invalid command"],
               status: :error
             }
    end
  end

  describe "add_response/2" do
    test "should add the responses" do
      result =
        Command.parse([])
        |> Command.add_response("first")
        |> Command.add_response("second")

      assert result.response == ["first", "second"]
      assert result.status == :ok
    end
  end

  describe "add_error" do
    test "should update the status from :ok to :error" do
      result =
        Command.parse([])
        |> Command.add_response("first")
        |> Command.add_response("second")
        |> Command.add_error("oops")
        |> Command.add_error("it broke")

      assert result.response == ["oops", "it broke"]
      assert result.status == :error
    end
  end
end

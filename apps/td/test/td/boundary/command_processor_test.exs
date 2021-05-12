defmodule TD.Boundary.CommandProcessorTest do
  use ExUnit.Case

  alias TD.Core.Command
  alias TD.Boundary.CommandProcessor
  alias Core.Task

  setup do
    Tesla.Mock.mock(fn env ->
      case env do
        %{method: :post, url: "http://localhost:4001/task", body: body} ->
          %Tesla.Env{status: 200, body: Jason.encode!([Jason.decode!(body)])}

        _ ->
          %Tesla.Env{status: 404}
      end
    end)

    :ok
  end

  describe "Command in an error status" do
    test "it should not be changed" do
      cmd =
        Command.parse(["add", "yo dawg"])
        |> Command.add_error("it died")

      result = CommandProcessor.process(cmd)

      assert cmd == result
    end
  end

  describe "add" do
    test "it should collect the response to strings" do
      result =
        Command.parse(["add", "yo dawg"])
        |> CommandProcessor.process()

      assert result.response == ["yo dawg"]
      assert result.status == :ok
    end
  end
end

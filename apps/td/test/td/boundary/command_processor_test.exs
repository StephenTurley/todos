defmodule TD.Boundary.CommandProcessorTest do
  use ExUnit.Case
  import Tesla.Mock

  alias TD.Core.Command
  alias TD.Boundary.CommandProcessor

  describe "Command in an error status" do
    test "it should not be changed" do
      cmd =
        Command.parse(["add", "yo dawg"])
        |> Command.add_error("it died")

      result = CommandProcessor.process(cmd)

      assert cmd == result
    end
  end

  describe "add with server error" do
    setup :stub_error

    test "it should return an error status" do
      result =
        Command.parse(["add", "yo dawg"])
        |> CommandProcessor.process()

      assert result.response == ["Server Error"]
      assert result.status == :error
    end
  end

  describe "add" do
    setup :stub_add

    test "it should collect the response to strings" do
      result =
        Command.parse(["add", "yo dawg"])
        |> CommandProcessor.process()

      assert result.response == ["yo dawg"]
      assert result.status == :ok
    end
  end

  defp stub_error(_) do
    mock(fn _ -> json("{}", status: 500) end)
    :ok
  end

  defp stub_add(_) do
    mock(fn %{method: :post, url: "http://localhost:4001/task", body: body} ->
      json(~s([#{body}]), status: 201)
    end)

    :ok
  end
end
defmodule TD.Boundary.CommandProcessorTest do
  use ExUnit.Case
  import Tesla.Mock

  alias TD.Core.Command
  alias TD.Boundary.CommandProcessor
  alias Core.Task

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

    test "it should collect the tasks" do
      result =
        Command.parse(["add", "yo dawg"])
        |> CommandProcessor.process()

      assert result.tasks == [Task.new(title: "yo dawg")]
      assert result.status == :ok
    end
  end

  describe "done" do
    setup do
      stub_complete_task(result: [Task.new(title: 'some flerpn'), Task.new(title: 'some derpn')])

      :ok
    end

    test "it should find and update the correct task" do
      result =
        Command.parse(["done", "some flerpn"])
        |> CommandProcessor.process()

      assert result.body == "some flerpn"

      assert result.tasks == [
               Task.new(title: 'some flerpn'),
               Task.new(title: 'some derpn')
             ]
    end
  end

  describe "all" do
    setup :stub_all

    test "it should collect the tasks" do
      result = Command.parse([]) |> CommandProcessor.process()

      assert result.tasks == [
               Task.new(id: 1, title: "you"),
               Task.new(id: 2, title: "did it")
             ]

      assert result.status == :ok
    end
  end

  describe "all with error" do
    setup :stub_error

    test "it should collect the response to strings" do
      result = Command.parse([]) |> CommandProcessor.process()

      assert result.response == ["Server Error"]
      assert result.status == :error
    end
  end

  # not a setup function.. kind of awkward
  defp stub_complete_task(result: body) do
    url = "http://localhost:4001/task/complete?title=some+flerpn"

    mock(fn %{method: :post, url: ^url} ->
      json(Jason.encode!(body), status: 200)
    end)
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

  defp stub_all(_) do
    response = [Task.new(id: 1, title: "you"), Task.new(id: 2, title: "did it")]

    mock(fn %{method: :get, url: "http://localhost:4001/task"} ->
      json(Jason.encode!(response))
    end)

    :ok
  end
end

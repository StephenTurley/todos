defmodule TD.Core.CommandRendererTest do
  use ExUnit.Case

  alias TD.Core.Command
  alias TD.Core.CommandRenderer
  alias Core.Task

  test "it renders tasks" do
    result =
      Command.new(type: :all)
      |> Command.set_tasks([
        Task.new(title: "One"),
        Task.new(title: "Two")
      ])
      |> CommandRenderer.generate_response()

    assert to_string(result.response) ==
             "\e[32mCompleted 0/2\e[31m✗ \e[36mOne\e[0m\e[31m✗ \e[36mTwo\e[0m"
  end
end

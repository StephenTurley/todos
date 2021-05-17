defmodule TD.Core.CommandParser do
  alias TD.Core.Command
  alias Core.Task
  alias Core.Boundary.TaskValidator

  def parse(args) do
    OptionParser.parse(args,
      aliases: [c: :complete, a: :add],
      strict: [add: :string, complete: :string]
    )
    |> create()
  end

  defp create({[add: title], [], []}) do
    with task <- Task.new(title: title),
         :ok <- TaskValidator.errors(task) do
      Command.new(type: :add, body: task)
    else
      errors ->
        Command.new(type: :add, response: errors, status: :error)
    end
  end

  defp create({[complete: title], [], []}) do
    Command.new(type: :complete, body: title)
  end

  defp create({[], [], []}) do
    Command.new(type: :all)
  end

  defp create(_) do
    response = [
      "td [options] [args]",
      "td, Prints todo list",
      "-a, --add <title>, Add a task",
      "-c, --complete <title>, Complete a task"
    ]

    Command.new(type: :invalid, response: response, status: :error)
  end
end

defmodule TD.Core.CommandParser do
  alias TD.Core.Command
  alias Core.Task
  alias Core.Boundary.TaskValidator

  def parse(["add", title]) do
    with task <- Task.new(title: title),
         :ok <- TaskValidator.errors(task) do
      Command.new(type: :add, body: task)
    else
      errors ->
        Command.new(type: :add, response: errors, status: :error)
    end
  end

  def parse(["done", title]) do
    Command.new(type: :done, body: title)
  end

  def parse([]) do
    Command.new(type: :all)
  end

  def parse(_) do
    Command.new(type: :invalid, response: ["invalid command"], status: :error)
  end
end

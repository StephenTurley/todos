defmodule TD.Core.Command do
  defstruct [:type, :body, :response, :status]
  alias Core.Task
  alias Core.Boundary.TaskValidator

  def new(fields) do
    struct!(__MODULE__, fields)
  end

  def parse(["add", title]) do
    with task <- Task.new(title: title),
         :ok <- TaskValidator.errors(task) do
      new(type: :add, body: task, response: [], status: :ok)
    else
      errors ->
        new(type: :add, body: %{}, response: errors, status: :error)
    end
  end

  def parse([]) do
    new(type: :all, body: %{}, response: [], status: :ok)
  end

  def parse(_) do
    new(type: :invalid, body: %{}, response: ["invalid command"], status: :error)
  end
end
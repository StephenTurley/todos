defmodule TD.Core.Command do
  defstruct [:type, :body, :tasks, :response, :status]
  alias Core.Task
  alias Core.Boundary.TaskValidator

  def new(fields) do
    default = [body: %{}, tasks: [], response: [], status: :ok]
    struct!(__MODULE__, Keyword.merge(default, fields))
  end

  def parse(["add", title]) do
    with task <- Task.new(title: title),
         :ok <- TaskValidator.errors(task) do
      new(type: :add, body: task)
    else
      errors ->
        new(type: :add, response: errors, status: :error)
    end
  end

  def parse(["done", title]) do
    new(type: :done, body: title)
  end

  def parse([]) do
    new(type: :all)
  end

  def parse(_) do
    new(type: :invalid, response: ["invalid command"], status: :error)
  end

  def add_response(cmd, response) do
    responses = cmd.response ++ [response]
    Map.put(cmd, :response, responses)
  end

  def add_error(%{status: :ok} = cmd, error) do
    cmd
    |> Map.put(:status, :error)
    |> Map.put(:response, [])
    |> add_response(error)
  end

  def add_error(%{status: :error} = cmd, error) do
    add_response(cmd, error)
  end

  def set_tasks(cmd, tasks) do
    Map.put(cmd, :tasks, tasks)
  end
end

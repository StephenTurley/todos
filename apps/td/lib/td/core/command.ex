defmodule TD.Core.Command do
  defstruct [:type, :body, :tasks, :response, :status]
  alias TD.Core.CommandParser
  defdelegate parse(args), to: CommandParser

  def new(fields) do
    default = [body: %{}, tasks: [], response: [], status: :ok]
    struct!(__MODULE__, Keyword.merge(default, fields))
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

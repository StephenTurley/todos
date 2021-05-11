defmodule TD.Boundary.CommandProcessor do
  alias TD.Boundary.API
  alias TD.Core.Command
  alias Core.Task

  def process(%{status: :error} = cmd) do
    cmd
  end

  def process(%{type: :add, body: task} = cmd) do
    with {:ok, response} <- API.add_task(task) do
      response.body
      |> Jason.decode!(keys: :atoms!)
      |> Enum.map(&task_string/1)
      |> List.foldl(cmd, &collect_response/2)
    else
      _error ->
        Command.add_error(cmd, "Server Error")
    end
  end

  def process(%{type: :all} = cmd) do
    cmd
  end

  defp task_string(json) do
    json
    |> Task.new()
    |> Task.toString()
  end

  defp collect_response(response, command) do
    Command.add_response(command, response)
  end
end

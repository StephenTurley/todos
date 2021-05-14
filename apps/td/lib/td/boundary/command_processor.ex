defmodule TD.Boundary.CommandProcessor do
  alias TD.Boundary.API
  alias TD.Core.Command
  alias Core.Task

  def process(%{status: :error} = cmd) do
    cmd
  end

  def process(%{type: :add, body: task} = cmd) do
    with {:ok, %{status: 201} = response} <- API.add_task(task) do
      handle_response(response.body, cmd)
    else
      _error ->
        Command.add_error(cmd, "Server Error")
    end
  end

  def process(%{type: :all} = cmd) do
    with {:ok, %{status: 200} = response} <- API.all() do
      handle_response(response.body, cmd)
    else
      _error ->
        Command.add_error(cmd, "Server Error")
    end
  end

  defp handle_response(body, cmd) do
    body
    |> Jason.decode!(keys: :atoms!)
    |> Enum.map(&Task.new/1)
    |> set_tasks(cmd)
  end

  defp set_tasks(tasks, command) do
    Command.set_tasks(command, tasks)
  end
end

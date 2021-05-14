defmodule TD.Boundary.CommandProcessor do
  alias TD.Boundary.API
  alias TD.Core.Command
  alias Core.Task

  def process(%{status: :error} = cmd) do
    cmd
  end

  def process(%{type: :add, body: task} = cmd) do
    API.add_task(task)
    |> handle_response(cmd)
  end

  def process(%{type: :all} = cmd) do
    API.all()
    |> handle_response(cmd)
  end

  def process(%{type: :done} = cmd) do
    cmd
  end

  defp handle_response({:ok, %{status: status, body: body}}, cmd)
       when status in [200, 201] do
    body
    |> Jason.decode!(keys: :atoms!)
    |> Enum.map(&Task.new/1)
    |> set_tasks(cmd)
  end

  defp handle_response(_, cmd) do
    Command.add_error(cmd, "Server Error")
  end

  defp set_tasks(tasks, command) do
    Command.set_tasks(command, tasks)
  end
end

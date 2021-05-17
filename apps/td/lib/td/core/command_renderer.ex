defmodule TD.Core.CommandRenderer do
  alias TD.Core.Command
  # ✗✓

  def generate_response(%{status: :error} = cmd), do: cmd

  def generate_response(cmd) do
    cmd
    |> response_header()
    |> render_tasks()
  end

  defp response_header(cmd) do
    completed =
      cmd.tasks
      |> Enum.filter(fn t -> t.is_complete end)
      |> Enum.count()
      |> to_string()

    total =
      cmd.tasks
      |> Enum.count()
      |> to_string

    header = IO.ANSI.green() <> "Completed #{completed}/#{total}"
    Command.add_response(cmd, header)
  end

  defp render_tasks(cmd) do
    cmd.tasks
    |> Enum.map(&render_task/1)
    |> List.foldl(cmd, &collect_responses/2)
  end

  defp render_task(%{is_complete: false} = task) do
    IO.ANSI.format([:red, "✗ ", :white, task.title], true)
  end

  defp render_task(%{is_complete: true} = task) do
    IO.ANSI.format([:green, "✓ ", :white, task.title], true)
  end

  defp collect_responses(res, cmd) do
    Command.add_response(cmd, res)
  end
end

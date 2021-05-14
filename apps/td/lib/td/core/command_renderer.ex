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
    total = Enum.count(cmd.tasks)
    header = IO.ANSI.green() <> "Completed 0/#{to_string(total)}"
    Command.add_response(cmd, header)
  end

  defp render_tasks(cmd) do
    cmd.tasks
    |> Enum.map(&render_task/1)
    |> List.foldl(cmd, &collect_responses/2)
  end

  defp render_task(task) do
    IO.ANSI.format([:red, "✗ ", :cyan, task.title], true)
  end

  defp collect_responses(res, cmd) do
    Command.add_response(cmd, res)
  end
end

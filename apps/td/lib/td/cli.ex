defmodule TD.CLI do
  alias Core.Server

  def main(args) do
    with :ok <- process(args) do
      System.stop(0)
    else
      _error -> System.stop(1)
    end

    # options = [switches: [file: :string], aliases: [f: :file]]
    # {opts, _, _} = OptionParser.parse(args, options)
    # IO.inspect(opts, label: "Command Line Arguments")
  end

  defp process(["add", title]) do
    Server.add_task(%{title: title})
  end

  defp process([]) do
    with {:ok, tasks} <- Server.all() do
      Enum.map(tasks, fn t -> IO.puts(t.title) end)
      :ok
    else
      _ -> :error
    end
  end

  defp process(_) do
    IO.puts(:stderr, "Invalid Command")
    :error
  end
end

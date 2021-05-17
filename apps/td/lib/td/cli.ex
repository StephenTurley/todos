defmodule TD.CLI do
  alias TD.Core.CommandParser
  alias TD.Core.CommandRenderer
  alias TD.Boundary.CommandProcessor

  def main(args) do
    CommandParser.parse(args)
    |> CommandProcessor.process()
    |> CommandRenderer.generate_response()
    |> print_response()
  end

  defp print_response(%{status: :ok, response: responses}) do
    Enum.each(responses, &IO.puts/1)
    System.stop(0)
  end

  defp print_response(%{status: :error, response: errors}) do
    Enum.each(errors, fn error -> IO.puts(:stderr, error) end)
    System.halt(1)
  end
end

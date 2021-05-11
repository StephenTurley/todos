defmodule TD.CLI do
  alias TD.Boundary.Command

  def main(args) do
    with {:ok, messages} <- Command.process(args) do
      Enum.each(messages, &IO.puts/1)
      System.stop(0)
    else
      {:error, errors} ->
        Enum.each(errors, fn error -> IO.puts(:stderr, error) end)
        System.halt(1)
    end
  end
end

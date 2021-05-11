defmodule TD.CLI do
  alias TD.Core.Command

  def main(args) do
    with %{status: :ok} <- cmd = Command.parse(args) do
      Enum.each(cmd.response, &IO.puts/1)
      System.stop(0)
    else
      %{status: :error} = cmd ->
        Enum.each(cmd.response, fn error -> IO.puts(:stderr, error) end)
        System.halt(1)
    end
  end
end

defmodule TD.Boundary.CommandProcessor do
  alias TD.Boundary.API

  def process(%{status: :error} = cmd), do: cmd

  def process(%{type: :add, body: task} = cmd) do
    with {:ok, response} <- API.add_task(task) do
      IO.inspect(response)
      cmd
    else
      error ->
        IO.inspect(error)
        cmd
    end

    cmd
  end

  def process(%{type: :all} = cmd) do
    cmd
  end
end

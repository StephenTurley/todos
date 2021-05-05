defmodule Server.Core.Task do
  defstruct [:title]

  def new(args) do
    struct!(__MODULE__, args)
  end
end

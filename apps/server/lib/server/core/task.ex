defmodule Server.Core.Task do
  @derive {Jason.Encoder, only: [:title]} # TODO should this be a response type... needs tested either way
  defstruct [:title]

  def new(args) do
    struct!(__MODULE__, args)
  end
end

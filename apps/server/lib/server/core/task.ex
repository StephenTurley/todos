defmodule Server.Core.Task do
  # TODO should this be a response type... needs tested either way
  @derive {Jason.Encoder, only: [:title]}
  defstruct [:title]

  def new(args) do
    struct!(__MODULE__, args)
  end
end

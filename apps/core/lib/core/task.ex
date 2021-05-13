defmodule Core.Task do
  @derive {Jason.Encoder, only: [:id, :title]}
  defstruct [:id, :title]

  def new(args) do
    struct!(__MODULE__, args)
  end

  def toString(task) do
    task.title
  end
end

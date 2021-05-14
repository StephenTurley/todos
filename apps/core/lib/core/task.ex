defmodule Core.Task do
  @derive {Jason.Encoder, only: [:id, :title, :is_complete]}
  defstruct [:id, :title, :is_complete]

  def new(args) when is_list(args) do
    defaults = [is_complete: false]
    struct!(__MODULE__, Keyword.merge(defaults, args))
  end

  def new(args) when is_map(args) do
    defaults = %{is_complete: false}
    struct!(__MODULE__, Map.merge(defaults, args))
  end

  def complete(task) do
    Map.put(task, :is_complete, true)
  end
end

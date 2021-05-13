defmodule Server.Core.TaskSchema do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field(:title, :string)
    timestamps()
  end

  def add_new_changeset(task) do
    cast(%__MODULE__{}, Map.from_struct(task), [:title])
  end
end

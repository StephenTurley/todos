defmodule Server.Core.TaskSchema do
  use Ecto.Schema
  import Ecto.Changeset

  @allowed [:title, :is_complete, :id]

  @primary_key {:id, :id, autogenerate: true}
  schema "tasks" do
    field(:title, :string)
    field(:is_complete, :boolean)
    timestamps()
  end

  def add_new_changeset(task) do
    cast(%__MODULE__{}, Map.from_struct(task), @allowed)
  end

  def change_is_complete(task, is_complete) do
    change(task, is_complete: is_complete)
  end
end

defmodule Server.Core.TaskSchemaTest do
  use ExUnit.Case

  alias Core.Task
  alias Server.Core.TaskSchema

  test "add_new_changeset" do
    task = Task.new(title: "Flerpn")

    %Ecto.Changeset{changes: result} = TaskSchema.add_new_changeset(task)

    assert result.title == "Flerpn"
  end
end

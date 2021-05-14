defmodule Server.Core.TaskSchemaTest do
  use ExUnit.Case

  alias Core.Task
  alias Server.Core.TaskSchema

  test "add_new_changeset" do
    task = Task.new(id: 19, title: "Flerpn", is_complete: true)

    %Ecto.Changeset{changes: result} = TaskSchema.add_new_changeset(task)

    assert result.id == 19
    assert result.title == "Flerpn"
    assert result.is_complete == true
  end
end

defmodule Server.Core.TaskPersistenceTest do
  use Server.RepoCase

  alias Server.Boundary.TaskPersistence
  alias Core.Task

  setup do
    TaskPersistence.clear()
    :ok
  end

  test "can create a task" do
    %{id: id, title: "foo"} = TaskPersistence.add(Task.new(title: "foo"))

    [result] = TaskPersistence.all()

    assert result.title == "foo"
    assert result.id == id
    assert result.id != nil
  end

  test "it can clear the db" do
    TaskPersistence.add(Task.new(title: "foo"))
    TaskPersistence.add(Task.new(title: "bar"))

    :ok = TaskPersistence.clear()

    result = TaskPersistence.all()
    assert result == []
  end
end

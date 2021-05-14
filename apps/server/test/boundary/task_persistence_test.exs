defmodule Server.Core.TaskPersistenceTest do
  use Server.RepoCase, async: false

  alias Server.Boundary.TaskPersistence
  alias Core.Task

  setup do
    TaskPersistence.clear()
    :ok
  end

  test "can create a task" do
    %Task{id: id, title: "foo", is_complete: true} =
      TaskPersistence.add(Task.new(title: "foo", is_complete: true))

    [result] = TaskPersistence.all()

    assert result.title == "foo"
    assert result.id == id
    assert result.id != nil
    assert result.is_complete == true
  end

  test "it can clear the db" do
    TaskPersistence.add(Task.new(title: "foo"))
    TaskPersistence.add(Task.new(title: "bar"))

    :ok = TaskPersistence.clear()

    result = TaskPersistence.all()
    assert result == []
  end

  test "it can find by title" do
    TaskPersistence.add(Task.new(title: "foo"))
    TaskPersistence.add(Task.new(title: "bar"))

    %Task{title: title} = TaskPersistence.find_by(title: "foo")

    assert title == "foo"
  end

  test "it can update is_complete" do
    result =
      TaskPersistence.add(Task.new(title: "foo"))
      |> Task.complete()
      |> TaskPersistence.update_is_complete()

    assert result.is_complete == true
  end
end

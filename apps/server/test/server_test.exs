defmodule ServerTest do
  use Server.RepoCase, async: false
  alias Server.Boundary.TaskPersistence, as: DB
  alias Core.Task

  setup do
    DB.clear()
  end

  test "you can get all tasks" do
    DB.add(Task.new(title: "Flerpn"))
    DB.add(Task.new(title: "Derpn"))

    {:ok, tasks} = Server.all()
    titles = Enum.map(tasks, fn t -> t.title end)
    assert titles == ["Flerpn", "Derpn"]
  end

  test "you can add a task" do
    {:ok, task} = Server.add_task(%{title: "Foo"})

    assert task.title == "Foo"

    {:ok, [persisted]} = Server.all()

    assert persisted.id != nil
    assert persisted.title == task.title
  end

  test "can complete a task" do
    DB.add(Task.new(title: "Flerpn", is_complete: false))

    Server.complete_task("Flerpn")

    {:ok, [task]} = Server.all()

    assert task.is_complete
  end

  describe "validations" do
    test "you must have a title" do
      assert ["title is required"] == Server.add_task(%{})
    end
  end
end

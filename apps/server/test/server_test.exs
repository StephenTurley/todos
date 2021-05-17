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

    titles = Enum.map(Server.all(), & &1.title)
    assert titles == ["Flerpn", "Derpn"]
  end

  test "you can add a task" do
    {:ok, task} = Server.add_task(%{title: "Foo"})

    assert task.title == "Foo"

    {:ok, [persisted]} = Server.all()

    assert persisted.id != nil
    assert persisted.title == task.title
  end

  describe "validations" do
    test "you must have a title" do
      assert ["title is required"] == Server.add_task(%{})
    end
  end
end

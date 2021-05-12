defmodule Server.Core.TaskRepoTest do
  use Server.RepoCase

  alias Server.Boundary.TaskRepo
  alias Server.Core.TaskSchema

  test "can create a task" do
    {:ok, %{id: id}} = TaskRepo.insert(%TaskSchema{title: "foo"})

    result = TaskRepo.get(TaskSchema, id)

    assert result.title == "foo"
  end
end

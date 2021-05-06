defmodule TaskValidatorTest do
  use ExUnit.Case
  alias Server.Boundary.TaskValidator
  alias Server.Core.Task

  test "returns ok for valid task" do
    assert :ok = TaskValidator.errors(%{title: "foo"})
  end

  test "it requires a title" do
    assert [{:error, "title is required"}] = TaskValidator.errors(%{})
  end

  test "title must be a string" do
    assert [{:error, "title must be a string"}] = TaskValidator.errors(%{title: 10})
  end

  test "title must not be empty" do
    assert [{:error, "title must not be empty"}] = TaskValidator.errors(%{title: ""})
  end
end

defmodule RouterTest do
  use ExUnit.Case, async: false
  use Plug.Test

  alias Boundary.TaskManager
  alias Server.Boundary.TaskRepo

  @opts Router.init([])

  setup do
    TaskManager.clear()
  end

  describe "getting tasks" do
    test "returns all the tasks" do
      tasks = [%{title: "foo"}, %{title: "bar"}]

      Enum.each(tasks, fn t -> TaskManager.add(t) end)

      conn =
        conn(:get, "/task")
        |> Plug.Conn.put_req_header("accept", "application/json")
        |> Router.call(@opts)

      assert conn.state == :sent
      assert conn.status == 200
      assert conn.resp_body == Jason.encode!(tasks)
    end
  end

  describe "adding a task" do
    test "updates the list" do
      conn = post(Jason.encode!(%{"title" => "FlerpnDerpn"}))

      assert conn.state == :sent
      assert conn.status == 201
      assert conn.resp_body == Jason.encode!([%{"title" => "FlerpnDerpn"}])
    end

    test "returns 400 error when title is missing" do
      conn = post(Jason.encode!(%{}))

      assert conn.state == :sent
      assert conn.status == 400
    end

    defp post(task) do
      conn(:post, "/task", task)
      |> Plug.Conn.put_req_header("content-type", "application/json")
      |> Plug.Conn.put_req_header("accept", "application/json")
      |> Router.call(@opts)
    end
  end

  describe "not found" do
    test "returns a 404" do
      conn =
        conn(:get, "/not_a_thing")
        |> Router.call(@opts)

      assert conn.state == :sent
      assert conn.status == 404
    end
  end
end

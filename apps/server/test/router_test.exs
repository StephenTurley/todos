defmodule RouterTest do
  use ExUnit.Case, async: false
  use Plug.Test

  alias Server.Boundary.TaskManager

  @opts Router.init([])

  setup do
    %{pid: start_supervised!(TaskManager)}
  end

  describe "adding a task" do
    test "updates the list" do
      task = Jason.encode!(%{"title" => "FlerpnDerpn"})

      conn =
        conn(:post, "/task", task)
        |> Plug.Conn.put_req_header("content-type", "application/json")
        |> Plug.Conn.put_req_header("accept", "application/json")
        |> Router.call(@opts)

      assert conn.state == :sent
      assert conn.status == 200
      assert conn.resp_body == Jason.encode!([%{"title" => "FlerpnDerpn"}])
    end

    test "returns 400 error when title is missing" do
      task = Jason.encode!(%{})

      conn =
        conn(:post, "/task", task)
        |> Plug.Conn.put_req_header("content-type", "application/json")
        |> Plug.Conn.put_req_header("accept", "application/json")
        |> Router.call(@opts)

      assert conn.state == :sent
      assert conn.status == 400
    end
  end
end

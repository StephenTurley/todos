defmodule Server.Boundary.TaskController do
  import Plug.Conn
  alias Core.Server

  def send_all(res, status \\ 200)

  def send_all({:error, conn}, _status) do
    send_resp(conn, 400, "bad request")
  end

  def send_all({:ok, conn}, status) do
    with {:ok, tasks} <- Server.all() do
      send_resp(conn, status, Jason.encode!(tasks))
    end
  end

  def add_task(conn) do
    with task <- create_task(conn.body_params),
         {:ok, _} <- Server.add_task(task) do
      {:ok, conn}
    else
      _errors -> {:error, conn}
    end
  end

  def create_task(params) do
    %{title: params["title"]}
  end
end

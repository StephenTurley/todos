defmodule Router do
  use Plug.Router
  import Plug.Conn

  plug(:match)
  plug(Plug.Parsers, parsers: [:json], json_decoder: Jason)
  plug(:dispatch)

  post "/task" do
    conn
    |> add_task
    |> send_all
  end

  defp send_all({:error, conn}) do
    send_resp(conn, 400, "bad request")
  end

  defp send_all({:ok, conn}) do
    with {:ok, tasks} <- Server.all() do
      send_resp(conn, 200, Jason.encode!(tasks))
    end
  end

  defp add_task(conn) do
    with task <- create_task(conn.body_params),
         :ok <- Server.add_task(task) do
      {:ok, conn}
    else
      _errors -> {:error, conn}
    end
  end

  defp create_task(params) do
    %{title: params["title"]}
  end
end

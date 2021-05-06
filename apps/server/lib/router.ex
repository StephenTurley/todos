defmodule Router do
  use Plug.Router
  import Plug.Conn

  plug(:match)
  plug(Plug.Parsers, parsers: [:json], json_decoder: Jason)
  plug(:dispatch)

  post "/task" do
    conn
    |> create_task
    |> send_all
  end

  defp send_all(conn) do
    with {:ok, tasks} = Server.all() do
      send_resp(conn, 200, Jason.encode!(tasks))
    end
  end

  defp create_task(conn) do
    with title = Map.get(conn.body_params, "title"),
         :ok = Server.add_task(title: title) do
      conn
    end
  end
end

defmodule Router do
  use Plug.Router
  import Plug.Conn
  alias Core.Server

  plug(:match)
  plug(Plug.Parsers, parsers: [:json], json_decoder: Jason)
  plug(:dispatch)

  post "/task" do
    conn
    |> add_task
    |> send_all(201)
  end

  get "/task" do
    send_all({:ok, conn})
  end

  defp send_all(res, status \\ 200)

  defp send_all({:error, conn}, _status) do
    send_resp(conn, 400, "bad request")
  end

  defp send_all({:ok, conn}, status) do
    with {:ok, tasks} <- Server.all() do
      send_resp(conn, status, Jason.encode!(tasks))
    end
  end

  defp add_task(conn) do
    with task <- create_task(conn.body_params),
         {:ok, _} <- Server.add_task(task) do
      {:ok, conn}
    else
      _errors -> {:error, conn}
    end
  end

  defp create_task(params) do
    %{title: params["title"]}
  end
end

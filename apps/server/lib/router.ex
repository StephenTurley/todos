defmodule Router do
  use Plug.Router

  alias Server.Boundary.TaskController, as: TD

  plug(:match)
  plug(Plug.Parsers, parsers: [:json], json_decoder: Jason)
  plug(:dispatch)

  post "/task" do
    conn
    |> TD.add_task()
    |> TD.send_all(201)
  end

  get "/task" do
    TD.send_all({:ok, conn})
  end

  match _ do
    send_resp(conn, 404, "not found")
  end
end

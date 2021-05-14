defmodule Router do
  use Plug.Router

  alias Server.Boundary.TaskController, as: TC

  plug(:match)
  plug(Plug.Parsers, parsers: [:json], json_decoder: Jason)
  plug(Plug.Logger, log: :debug)
  plug(:dispatch)

  post "/task" do
    conn
    |> TC.add_task()
    |> TC.send_all(201)
  end

  get "/task" do
    TC.send_all({:ok, conn})
  end

  post "/task/complete" do
    conn
    |> TC.complete_task()
    |> TC.send_all(201)
  end

  match _ do
    send_resp(conn, 404, "not found")
  end
end

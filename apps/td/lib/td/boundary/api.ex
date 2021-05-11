defmodule TD.Boundary.API do
  use Tesla

  plug(Tesla.Middleware.BaseUrl, "http://localhost:4001")
  plug(Tesla.Middleware.JSON)

  def add_task(task) do
    post("/task", task)
  end

  def all do
    get("/task")
  end
end

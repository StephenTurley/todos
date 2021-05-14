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

  def complete_task(title) do
    url = Tesla.build_url("/task/complete", [{:title, title}])
    post(url, %{})
  end
end

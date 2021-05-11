defmodule TD.Boundary.Command do
  defstruct [:type, :body, :response, :status]

  def new(fields) do
    struct!(__MODULE__, fields)
  end

  def parse(["add", title]) do
    new(type: "add", body: %{title: title}, response: [], status: :ok)
  end

  def parse([]) do
    new(type: "all", body: nil, response: [], status: :ok)
  end

  def parse(_) do
    new(type: "invalid", body: nil, response: ["Invalid Command"], status: :error)
  end
end

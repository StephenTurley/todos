defmodule Server.Core.TaskSchema do
  use Ecto.Schema

  schema "tasks" do
    field(:title, :string)
    timestamps()
  end
end

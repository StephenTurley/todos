defmodule Server.Boundary.TaskRepo.Migrations.AddIsCompleteToTasks do
  use Ecto.Migration

  def change do
    alter table("tasks") do
      add(:is_complete, :boolean, default: false)
    end
  end
end

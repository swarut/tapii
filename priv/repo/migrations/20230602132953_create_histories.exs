defmodule Tapii.Repo.Migrations.CreateHistories do
  use Ecto.Migration

  def change do
    create table(:histories) do
      add :status, :string
      add :result, :text
      add :scheduler_id, references(:schedulers, on_delete: :nothing)

      timestamps()
    end

    create index(:histories, [:scheduler_id])
  end
end

defmodule Tapii.Repo.Migrations.CreateSchedulerSubstitutions do
  use Ecto.Migration

  def change do
    create table(:scheduler_substitutions) do
      add :key, :string
      add :value, :string
      add :scheduler_id, references(:schedulers, on_delete: :nothing)

      timestamps()
    end

    create index(:scheduler_substitutions, [:scheduler_id])
  end
end

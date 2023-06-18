defmodule Tapii.Repo.Migrations.CreateSchedulers do
  use Ecto.Migration

  def change do
    create table(:schedulers) do
      add :schedule_time, :time
      add :occurence, :integer
      add :active, :boolean, default: false, null: false
      add :query_template_id, references(:query_templates, on_delete: :nothing)

      timestamps()
    end

    create index(:schedulers, [:query_template_id])
    create index(:schedulers, [:active])
    create index(:schedulers, [:schedule_time])
  end
end

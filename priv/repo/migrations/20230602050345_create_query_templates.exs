defmodule Tapii.Repo.Migrations.CreateQueryTemplates do
  use Ecto.Migration

  def change do
    create table(:query_templates) do
      add :name, :string
      add :query, :text
      add :query_template_group_id, references(:query_template_groups, on_delete: :nothing)

      timestamps()
    end

    create index(:query_templates, [:query_template_group_id])
  end
end

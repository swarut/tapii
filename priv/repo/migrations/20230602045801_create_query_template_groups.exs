defmodule Tapii.Repo.Migrations.CreateQueryTemplateGroups do
  use Ecto.Migration

  def change do
    create table(:query_template_groups) do
      add :name, :string

      timestamps()
    end
  end
end

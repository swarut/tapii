defmodule Tapii.QueryEngines.QueryTemplate do
  use Ecto.Schema
  import Ecto.Changeset

  schema "query_templates" do
    field :name, :string
    field :query, :string
    field :query_template_group_id, :id

    timestamps()
  end

  @doc false
  def changeset(query_template, attrs) do
    query_template
    |> cast(attrs, [:name, :query, :query_template_group_id])
    |> validate_required([:name, :query, :query_template_group_id])
  end
end
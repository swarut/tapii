defmodule Tapii.QueryEngines.QueryTemplateGroup do
  use Ecto.Schema
  import Ecto.Changeset

  schema "query_template_groups" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(query_template_group, attrs) do
    query_template_group
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end

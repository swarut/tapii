defmodule Tapii.Schedulers.Scheduler do
  use Ecto.Schema
  import Ecto.Changeset

  schema "schedulers" do
    field :active, :boolean, default: false
    field :occurence, :integer
    field :time, :time
    field :query_template_id, :id

    timestamps()
  end

  @doc false
  def changeset(scheduler, attrs) do
    scheduler
    |> cast(attrs, [:time, :occurence, :active, :query_template_id])
    |> validate_required([:time, :occurence, :active, :query_template_id])
  end
end

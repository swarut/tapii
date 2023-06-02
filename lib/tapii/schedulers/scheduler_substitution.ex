defmodule Tapii.Schedulers.SchedulerSubstitution do
  use Ecto.Schema
  import Ecto.Changeset

  schema "scheduler_substitutions" do
    field :key, :string
    field :value, :string
    field :scheduler_id, :id

    timestamps()
  end

  @doc false
  def changeset(scheduler_substitution, attrs) do
    scheduler_substitution
    |> cast(attrs, [:key, :value, :scheduler_id])
    |> validate_required([:key, :value, :scheduler_id])
  end
end

defmodule Tapii.Schedulers.History do
  use Ecto.Schema
  import Ecto.Changeset

  schema "histories" do
    field :result, :string
    field :status, Ecto.Enum, values: [:completed, :cancelled, :failed]
    belongs_to :scheduler, Tapii.Schedulers.Scheduler

    timestamps()
  end

  @doc false
  def changeset(history, attrs) do
    history
    |> cast(attrs, [:status, :result, :scheduler_id])
    |> validate_required([:status, :result, :scheduler_id])
  end
end

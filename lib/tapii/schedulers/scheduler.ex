defmodule Tapii.Schedulers.Scheduler do
  use Ecto.Schema
  import Ecto.Changeset

  schema "schedulers" do
    field :active, :boolean, default: false
    field :occurence, :integer
    field :schedule_time, :time
    belongs_to :query_template, Tapii.QueryEngines.QueryTemplate
    has_many :histories, Tapii.Schedulers.History

    timestamps()
  end

  @doc false
  def changeset(scheduler, attrs) do
    scheduler
    |> cast(attrs, [:schedule_time, :occurence, :active, :query_template_id])
    |> validate_required([:schedule_time, :occurence, :active, :query_template_id])
  end
end

defmodule TapiiWeb.SchedulerLive.HistoryListComponent do
  use TapiiWeb, :live_component
  require Logger

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.table
        id="scheduler-histories"
        rows={@histories}
      >
        <:col :let={history} label="ID"><%= history.id %></:col>
        <:col :let={history} label="Status"><%= history.status %></:col>
        <:col :let={history} label="Result">result here <%= history.status %></:col>
        <:col :let={history} label="Inserted at"><%= history.inserted_at %></:col>
      </.table>
    </div>

    """
  end
end

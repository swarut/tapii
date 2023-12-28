defmodule TapiiWeb.SchedulerLive.HistoryListComponent do
  use TapiiWeb, :live_component

  alias Tapii.Schedulers
  alias Tapii.Pon

  require Logger

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      This is a list of history

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

  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage query_template records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="query_template-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:query]} type="textarea" cols="40" rows="10" label="Query" />
        <.input field={@form[:query_template_group_id]} type="text" label="Query Template Group" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Query template</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end
end

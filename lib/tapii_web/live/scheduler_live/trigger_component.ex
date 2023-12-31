defmodule TapiiWeb.SchedulerLive.TriggerComponent do
  use TapiiWeb, :live_component

  # alias Tapii.Schedulers

  # alias Tapii.Pon

  require Logger

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      ura this is a sooner trigger component
    </div>
    """
    # <.header phx-click={JS.push("trigger", value: assigns[:scheduler].id)}>
    #     Trigger Component for scheduler <%= assigns[:scheduler].id %>
    #   </.header>
  end

  # @impl true
  # def update(%{scheduler: scheduler} = assigns, socket) do
  #   changeset = Schedulers.change_scheduler(scheduler)

  #   {:ok,
  #    socket
  #    |> assign(assigns)
  #    |> assign_form(changeset)}
  # end

  @impl true
  def handle_event("trigger", _, socket) do
    # changeset =
    #   socket.assigns.scheduler
    #   |> Schedulers.change_scheduler(scheduler_params)
    #   |> Map.put(:action, :validate)

    # {:noreply, assign_form(socket, changeset)}
    IO.puts("Trigger component --- uraura")
    {:noreply, socket}
  end
end

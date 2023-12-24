defmodule TapiiWeb.SchedulerLive.TriggerComponent do
  use TapiiWeb, :live_component

  # alias Tapii.Schedulers
  # alias Tapii.Pon

  require Logger

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        Trigger
      </.header>
    </div>
    """
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
    IO.puts("Trigger component")
    {:noreply, socket}
  end
end

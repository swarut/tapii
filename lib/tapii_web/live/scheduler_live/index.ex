defmodule TapiiWeb.SchedulerLive.Index do
  use TapiiWeb, :live_view

  alias Tapii.Schedulers
  alias Tapii.Schedulers.Scheduler

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :schedulers, Schedulers.list_schedulers())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Scheduler")
    |> assign(:scheduler, Schedulers.get_scheduler!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Scheduler")
    |> assign(:scheduler, %Scheduler{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Schedulers")
    |> assign(:scheduler, nil)
  end

  @impl true
  def handle_info({TapiiWeb.SchedulerLive.FormComponent, {:saved, scheduler}}, socket) do
    {:noreply, stream_insert(socket, :schedulers, scheduler)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    scheduler = Schedulers.get_scheduler!(id)
    {:ok, _} = Schedulers.delete_scheduler(scheduler)

    {:noreply, stream_delete(socket, :schedulers, scheduler)}
  end
end

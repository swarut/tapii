defmodule TapiiWeb.SchedulerLive.Index do
  use TapiiWeb, :live_view

  alias Tapii.Schedulers
  alias Tapii.Schedulers.Scheduler
  alias Tapii.QueryEngines

  @impl true
  def mount(_params, _session, socket) do
    Phoenix.PubSub.subscribe(Tapii.PubSub, "histories")

    {
      :ok,
      socket
      |> assign(:query_templates, QueryEngines.list_query_templates() |> query_templates_for_options)
      |> stream(:schedulers, Schedulers.list_schedulers())
    }
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
  def handle_info({:new, history}, socket) do
    socket = socket |> put_flash(:info, "Job was completed, the history was create. #{history.id} for scheduler_id #{history.scheduler_id}")
    scheduler = Tapii.Schedulers.get_scheduler!(history.scheduler_id)
    {:noreply, stream_insert(socket, :schedulers, scheduler)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    scheduler = Schedulers.get_scheduler!(id)
    {:ok, _} = Schedulers.delete_scheduler(scheduler)

    {:noreply, stream_delete(socket, :schedulers, scheduler)}
  end

  @impl true
  def handle_event("trigger", %{"id" => scheduler_id}, socket) do
    # scheduler = Schedulers.get_scheduler!(id)
    # {:ok, _} = Schedulers.delete_scheduler(scheduler)
    IO.puts("Trigger!!!! #{socket.assigns.live_action}  for user #{socket.assigns.current_user.id}")
    Tapii.ScheduleExecutor.start_link({socket.assigns.current_user.id, scheduler_id})

    {:noreply, socket |> put_flash(:info, "Scheduler was triggerred") }
  end

  defp query_templates_for_options(query_templates) do
    query_templates
    |> Enum.map(fn t -> [key: t.name, value: t.id] end)
  end
end

defmodule TapiiWeb.SchedulerSubstitutionLive.Index do
  use TapiiWeb, :live_view

  alias Tapii.Schedulers
  alias Tapii.Schedulers.SchedulerSubstitution

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :scheduler_substitutions, Schedulers.list_scheduler_substitutions())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Scheduler substitution")
    |> assign(:scheduler_substitution, Schedulers.get_scheduler_substitution!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Scheduler substitution")
    |> assign(:scheduler_substitution, %SchedulerSubstitution{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Scheduler substitutions")
    |> assign(:scheduler_substitution, nil)
  end

  @impl true
  def handle_info({TapiiWeb.SchedulerSubstitutionLive.FormComponent, {:saved, scheduler_substitution}}, socket) do
    {:noreply, stream_insert(socket, :scheduler_substitutions, scheduler_substitution)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    scheduler_substitution = Schedulers.get_scheduler_substitution!(id)
    {:ok, _} = Schedulers.delete_scheduler_substitution(scheduler_substitution)

    {:noreply, stream_delete(socket, :scheduler_substitutions, scheduler_substitution)}
  end
end

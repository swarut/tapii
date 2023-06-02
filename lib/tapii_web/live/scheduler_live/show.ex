defmodule TapiiWeb.SchedulerLive.Show do
  use TapiiWeb, :live_view

  alias Tapii.Schedulers

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:scheduler, Schedulers.get_scheduler!(id))}
  end

  defp page_title(:show), do: "Show Scheduler"
  defp page_title(:edit), do: "Edit Scheduler"
end

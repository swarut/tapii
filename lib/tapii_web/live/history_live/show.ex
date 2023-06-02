defmodule TapiiWeb.HistoryLive.Show do
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
     |> assign(:history, Schedulers.get_history!(id))}
  end

  defp page_title(:show), do: "Show History"
  defp page_title(:edit), do: "Edit History"
end

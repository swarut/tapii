defmodule TapiiWeb.QueryTemplateGroupLive.Show do
  use TapiiWeb, :live_view

  alias Tapii.QueryEngines

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:query_template_group, QueryEngines.get_query_template_group!(id))}
  end

  defp page_title(:show), do: "Show Query template group"
  defp page_title(:edit), do: "Edit Query template group"
end

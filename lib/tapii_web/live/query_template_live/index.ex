defmodule TapiiWeb.QueryTemplateLive.Index do
  use TapiiWeb, :live_view

  alias Tapii.QueryEngines
  alias Tapii.QueryEngines.QueryTemplate

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :query_templates, QueryEngines.list_query_templates())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Query template")
    |> assign(:query_template, QueryEngines.get_query_template!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Query template")
    |> assign(:query_template, %QueryTemplate{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Query templates")
    |> assign(:query_template, nil)
  end

  @impl true
  def handle_info({TapiiWeb.QueryTemplateLive.FormComponent, {:saved, query_template}}, socket) do
    {:noreply, stream_insert(socket, :query_templates, query_template)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    query_template = QueryEngines.get_query_template!(id)
    {:ok, _} = QueryEngines.delete_query_template(query_template)

    {:noreply, stream_delete(socket, :query_templates, query_template)}
  end
end

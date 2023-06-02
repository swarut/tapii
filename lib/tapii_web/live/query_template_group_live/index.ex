defmodule TapiiWeb.QueryTemplateGroupLive.Index do
  use TapiiWeb, :live_view

  alias Tapii.QueryEngines
  alias Tapii.QueryEngines.QueryTemplateGroup

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :query_template_groups, QueryEngines.list_query_template_groups())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Query template group")
    |> assign(:query_template_group, QueryEngines.get_query_template_group!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Query template group")
    |> assign(:query_template_group, %QueryTemplateGroup{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Query template groups")
    |> assign(:query_template_group, nil)
  end

  @impl true
  def handle_info({TapiiWeb.QueryTemplateGroupLive.FormComponent, {:saved, query_template_group}}, socket) do
    {:noreply, stream_insert(socket, :query_template_groups, query_template_group)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    query_template_group = QueryEngines.get_query_template_group!(id)
    {:ok, _} = QueryEngines.delete_query_template_group(query_template_group)

    {:noreply, stream_delete(socket, :query_template_groups, query_template_group)}
  end
end

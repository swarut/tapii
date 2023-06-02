defmodule TapiiWeb.HistoryLive.Index do
  use TapiiWeb, :live_view

  alias Tapii.Schedulers
  alias Tapii.Schedulers.History

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :histories, Schedulers.list_histories())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit History")
    |> assign(:history, Schedulers.get_history!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New History")
    |> assign(:history, %History{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Histories")
    |> assign(:history, nil)
  end

  @impl true
  def handle_info({TapiiWeb.HistoryLive.FormComponent, {:saved, history}}, socket) do
    {:noreply, stream_insert(socket, :histories, history)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    history = Schedulers.get_history!(id)
    {:ok, _} = Schedulers.delete_history(history)

    {:noreply, stream_delete(socket, :histories, history)}
  end
end

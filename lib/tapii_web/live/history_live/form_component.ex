defmodule TapiiWeb.HistoryLive.FormComponent do
  use TapiiWeb, :live_component

  alias Tapii.Schedulers

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage history records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="history-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input
          field={@form[:status]}
          type="select"
          label="Status"
          prompt="Choose a value"
          options={Ecto.Enum.values(Tapii.Schedulers.History, :status)}
        />
        <.input field={@form[:result]} type="text" label="Result" />
        <.input field={@form[:scheduler_id]} type="text" label="Scheduler" />
        <:actions>
          <.button phx-disable-with="Saving...">Save History</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{history: history} = assigns, socket) do
    changeset = Schedulers.change_history(history)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"history" => history_params}, socket) do
    changeset =
      socket.assigns.history
      |> Schedulers.change_history(history_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"history" => history_params}, socket) do
    save_history(socket, socket.assigns.action, history_params)
  end

  defp save_history(socket, :edit, history_params) do
    case Schedulers.update_history(socket.assigns.history, history_params) do
      {:ok, history} ->
        notify_parent({:saved, history})

        {:noreply,
         socket
         |> put_flash(:info, "History updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_history(socket, :new, history_params) do
    case Schedulers.create_history(history_params) do
      {:ok, history} ->
        notify_parent({:saved, history})

        {:noreply,
         socket
         |> put_flash(:info, "History created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end

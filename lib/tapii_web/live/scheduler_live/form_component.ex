defmodule TapiiWeb.SchedulerLive.FormComponent do
  use TapiiWeb, :live_component

  alias Tapii.Schedulers
  alias Tapii.Pon

  require Logger

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage scheduler records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="scheduler-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:schedule_time]} type="time" label="Schedule Time" />
        <.input field={@form[:occurence]} type="number" label="Occurence" />
        <.input field={@form[:active]} type="checkbox" label="Active" />
        <.input field={@form[:query_template_id]} type="select" label="Query Template" options={@query_templates} />
        <:actions>
          <.button phx-disable-with="Saving...">Save Scheduler</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{scheduler: scheduler} = assigns, socket) do
    changeset = Schedulers.change_scheduler(scheduler)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"scheduler" => scheduler_params}, socket) do
    changeset =
      socket.assigns.scheduler
      |> Schedulers.change_scheduler(scheduler_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"scheduler" => scheduler_params}, socket) do
    save_scheduler(socket, socket.assigns.action, scheduler_params)
  end

  defp save_scheduler(socket, :edit, scheduler_params) do
    case Schedulers.update_scheduler(socket.assigns.scheduler, scheduler_params) do
      {:ok, scheduler} ->
        notify_parent({:saved, scheduler})

        {:noreply,
         socket
         |> put_flash(:info, "Scheduler updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_scheduler(socket, :new, scheduler_params) do
    case Schedulers.create_scheduler(scheduler_params) do
      {:ok, scheduler} ->
        notify_parent({:saved, scheduler})
        Supervisor.start_link([{Pon, name: Tapii.Pon}],  strategy: :one_for_one)

        {:noreply,
         socket
         |> put_flash(:info, "Scheduler created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg) do
    send(self(), {__MODULE__, msg})
  end
end

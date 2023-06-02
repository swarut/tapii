defmodule TapiiWeb.SchedulerSubstitutionLive.FormComponent do
  use TapiiWeb, :live_component

  alias Tapii.Schedulers

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage scheduler_substitution records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="scheduler_substitution-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:key]} type="text" label="Key" />
        <.input field={@form[:value]} type="text" label="Value" />
        <.input field={@form[:scheduler_id]} type="text" label="Scheduler" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Scheduler substitution</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{scheduler_substitution: scheduler_substitution} = assigns, socket) do
    changeset = Schedulers.change_scheduler_substitution(scheduler_substitution)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"scheduler_substitution" => scheduler_substitution_params}, socket) do
    changeset =
      socket.assigns.scheduler_substitution
      |> Schedulers.change_scheduler_substitution(scheduler_substitution_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"scheduler_substitution" => scheduler_substitution_params}, socket) do
    save_scheduler_substitution(socket, socket.assigns.action, scheduler_substitution_params)
  end

  defp save_scheduler_substitution(socket, :edit, scheduler_substitution_params) do
    case Schedulers.update_scheduler_substitution(socket.assigns.scheduler_substitution, scheduler_substitution_params) do
      {:ok, scheduler_substitution} ->
        notify_parent({:saved, scheduler_substitution})

        {:noreply,
         socket
         |> put_flash(:info, "Scheduler substitution updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_scheduler_substitution(socket, :new, scheduler_substitution_params) do
    case Schedulers.create_scheduler_substitution(scheduler_substitution_params) do
      {:ok, scheduler_substitution} ->
        notify_parent({:saved, scheduler_substitution})

        {:noreply,
         socket
         |> put_flash(:info, "Scheduler substitution created successfully")
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

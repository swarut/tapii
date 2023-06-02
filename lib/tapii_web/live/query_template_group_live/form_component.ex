defmodule TapiiWeb.QueryTemplateGroupLive.FormComponent do
  use TapiiWeb, :live_component

  alias Tapii.QueryEngines

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage query_template_group records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="query_template_group-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Query template group</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{query_template_group: query_template_group} = assigns, socket) do
    changeset = QueryEngines.change_query_template_group(query_template_group)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"query_template_group" => query_template_group_params}, socket) do
    changeset =
      socket.assigns.query_template_group
      |> QueryEngines.change_query_template_group(query_template_group_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"query_template_group" => query_template_group_params}, socket) do
    save_query_template_group(socket, socket.assigns.action, query_template_group_params)
  end

  defp save_query_template_group(socket, :edit, query_template_group_params) do
    case QueryEngines.update_query_template_group(socket.assigns.query_template_group, query_template_group_params) do
      {:ok, query_template_group} ->
        notify_parent({:saved, query_template_group})

        {:noreply,
         socket
         |> put_flash(:info, "Query template group updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_query_template_group(socket, :new, query_template_group_params) do
    case QueryEngines.create_query_template_group(query_template_group_params) do
      {:ok, query_template_group} ->
        notify_parent({:saved, query_template_group})

        {:noreply,
         socket
         |> put_flash(:info, "Query template group created successfully")
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

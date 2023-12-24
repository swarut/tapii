defmodule TapiiWeb.QueryTemplateLive.FormComponent do
  use TapiiWeb, :live_component

  alias Tapii.QueryEngines

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage query_template records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="query_template-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:query]} type="textarea" cols="40" rows="10" label="Query" />
        <.input field={@form[:query_template_group_id]} type="text" label="Query Template Group" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Query template</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{query_template: query_template} = assigns, socket) do
    changeset = QueryEngines.change_query_template(query_template)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"query_template" => query_template_params}, socket) do
    changeset =
      socket.assigns.query_template
      |> QueryEngines.change_query_template(query_template_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"query_template" => query_template_params}, socket) do
    save_query_template(socket, socket.assigns.action, query_template_params)
  end

  defp save_query_template(socket, :edit, query_template_params) do
    case QueryEngines.update_query_template(socket.assigns.query_template, query_template_params) do
      {:ok, query_template} ->
        notify_parent({:saved, query_template})

        {:noreply,
         socket
         |> put_flash(:info, "Query template updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_query_template(socket, :new, query_template_params) do
    case QueryEngines.create_query_template(query_template_params) do
      {:ok, query_template} ->
        notify_parent({:saved, query_template})

        {:noreply,
         socket
         |> put_flash(:info, "Query template created successfully")
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

defmodule Tapii.QueryEngines do
  @moduledoc """
  The QueryEngines context.
  """

  import Ecto.Query, warn: false
  alias Tapii.Repo

  alias Tapii.QueryEngines.QueryTemplateGroup

  @doc """
  Returns the list of query_template_groups.

  ## Examples

      iex> list_query_template_groups()
      [%QueryTemplateGroup{}, ...]

  """
  def list_query_template_groups do
    Repo.all(QueryTemplateGroup)
  end

  @doc """
  Gets a single query_template_group.

  Raises `Ecto.NoResultsError` if the Query template group does not exist.

  ## Examples

      iex> get_query_template_group!(123)
      %QueryTemplateGroup{}

      iex> get_query_template_group!(456)
      ** (Ecto.NoResultsError)

  """
  def get_query_template_group!(id), do: Repo.get!(QueryTemplateGroup, id)

  @doc """
  Creates a query_template_group.

  ## Examples

      iex> create_query_template_group(%{field: value})
      {:ok, %QueryTemplateGroup{}}

      iex> create_query_template_group(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_query_template_group(attrs \\ %{}) do
    %QueryTemplateGroup{}
    |> QueryTemplateGroup.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a query_template_group.

  ## Examples

      iex> update_query_template_group(query_template_group, %{field: new_value})
      {:ok, %QueryTemplateGroup{}}

      iex> update_query_template_group(query_template_group, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_query_template_group(%QueryTemplateGroup{} = query_template_group, attrs) do
    query_template_group
    |> QueryTemplateGroup.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a query_template_group.

  ## Examples

      iex> delete_query_template_group(query_template_group)
      {:ok, %QueryTemplateGroup{}}

      iex> delete_query_template_group(query_template_group)
      {:error, %Ecto.Changeset{}}

  """
  def delete_query_template_group(%QueryTemplateGroup{} = query_template_group) do
    Repo.delete(query_template_group)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking query_template_group changes.

  ## Examples

      iex> change_query_template_group(query_template_group)
      %Ecto.Changeset{data: %QueryTemplateGroup{}}

  """
  def change_query_template_group(%QueryTemplateGroup{} = query_template_group, attrs \\ %{}) do
    QueryTemplateGroup.changeset(query_template_group, attrs)
  end

  alias Tapii.QueryEngines.QueryTemplate

  @doc """
  Returns the list of query_templates.

  ## Examples

      iex> list_query_templates()
      [%QueryTemplate{}, ...]

  """
  def list_query_templates do
    Repo.all(QueryTemplate)
  end

  @doc """
  Gets a single query_template.

  Raises `Ecto.NoResultsError` if the Query template does not exist.

  ## Examples

      iex> get_query_template!(123)
      %QueryTemplate{}

      iex> get_query_template!(456)
      ** (Ecto.NoResultsError)

  """
  def get_query_template!(id), do: Repo.get!(QueryTemplate, id)

  @doc """
  Creates a query_template.

  ## Examples

      iex> create_query_template(%{field: value})
      {:ok, %QueryTemplate{}}

      iex> create_query_template(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_query_template(attrs \\ %{}) do
    %QueryTemplate{}
    |> QueryTemplate.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a query_template.

  ## Examples

      iex> update_query_template(query_template, %{field: new_value})
      {:ok, %QueryTemplate{}}

      iex> update_query_template(query_template, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_query_template(%QueryTemplate{} = query_template, attrs) do
    query_template
    |> QueryTemplate.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a query_template.

  ## Examples

      iex> delete_query_template(query_template)
      {:ok, %QueryTemplate{}}

      iex> delete_query_template(query_template)
      {:error, %Ecto.Changeset{}}

  """
  def delete_query_template(%QueryTemplate{} = query_template) do
    Repo.delete(query_template)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking query_template changes.

  ## Examples

      iex> change_query_template(query_template)
      %Ecto.Changeset{data: %QueryTemplate{}}

  """
  def change_query_template(%QueryTemplate{} = query_template, attrs \\ %{}) do
    QueryTemplate.changeset(query_template, attrs)
  end
end

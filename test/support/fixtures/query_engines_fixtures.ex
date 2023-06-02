defmodule Tapii.QueryEnginesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Tapii.QueryEngines` context.
  """

  @doc """
  Generate a query_template_group.
  """
  def query_template_group_fixture(attrs \\ %{}) do
    {:ok, query_template_group} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Tapii.QueryEngines.create_query_template_group()

    query_template_group
  end

  @doc """
  Generate a query_template.
  """
  def query_template_fixture(attrs \\ %{}) do
    {:ok, query_template} =
      attrs
      |> Enum.into(%{
        name: "some name",
        query: "some query"
      })
      |> Tapii.QueryEngines.create_query_template()

    query_template
  end
end

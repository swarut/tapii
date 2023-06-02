defmodule Tapii.QueryEnginesTest do
  use Tapii.DataCase

  alias Tapii.QueryEngines

  describe "query_template_groups" do
    alias Tapii.QueryEngines.QueryTemplateGroup

    import Tapii.QueryEnginesFixtures

    @invalid_attrs %{name: nil}

    test "list_query_template_groups/0 returns all query_template_groups" do
      query_template_group = query_template_group_fixture()
      assert QueryEngines.list_query_template_groups() == [query_template_group]
    end

    test "get_query_template_group!/1 returns the query_template_group with given id" do
      query_template_group = query_template_group_fixture()
      assert QueryEngines.get_query_template_group!(query_template_group.id) == query_template_group
    end

    test "create_query_template_group/1 with valid data creates a query_template_group" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %QueryTemplateGroup{} = query_template_group} = QueryEngines.create_query_template_group(valid_attrs)
      assert query_template_group.name == "some name"
    end

    test "create_query_template_group/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = QueryEngines.create_query_template_group(@invalid_attrs)
    end

    test "update_query_template_group/2 with valid data updates the query_template_group" do
      query_template_group = query_template_group_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %QueryTemplateGroup{} = query_template_group} = QueryEngines.update_query_template_group(query_template_group, update_attrs)
      assert query_template_group.name == "some updated name"
    end

    test "update_query_template_group/2 with invalid data returns error changeset" do
      query_template_group = query_template_group_fixture()
      assert {:error, %Ecto.Changeset{}} = QueryEngines.update_query_template_group(query_template_group, @invalid_attrs)
      assert query_template_group == QueryEngines.get_query_template_group!(query_template_group.id)
    end

    test "delete_query_template_group/1 deletes the query_template_group" do
      query_template_group = query_template_group_fixture()
      assert {:ok, %QueryTemplateGroup{}} = QueryEngines.delete_query_template_group(query_template_group)
      assert_raise Ecto.NoResultsError, fn -> QueryEngines.get_query_template_group!(query_template_group.id) end
    end

    test "change_query_template_group/1 returns a query_template_group changeset" do
      query_template_group = query_template_group_fixture()
      assert %Ecto.Changeset{} = QueryEngines.change_query_template_group(query_template_group)
    end
  end
end

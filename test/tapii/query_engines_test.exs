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

  describe "query_templates" do
    alias Tapii.QueryEngines.QueryTemplate

    import Tapii.QueryEnginesFixtures

    @invalid_attrs %{name: nil, query: nil}

    test "list_query_templates/0 returns all query_templates" do
      query_template = query_template_fixture()
      assert QueryEngines.list_query_templates() == [query_template]
    end

    test "get_query_template!/1 returns the query_template with given id" do
      query_template = query_template_fixture()
      assert QueryEngines.get_query_template!(query_template.id) == query_template
    end

    test "create_query_template/1 with valid data creates a query_template" do
      valid_attrs = %{name: "some name", query: "some query"}

      assert {:ok, %QueryTemplate{} = query_template} = QueryEngines.create_query_template(valid_attrs)
      assert query_template.name == "some name"
      assert query_template.query == "some query"
    end

    test "create_query_template/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = QueryEngines.create_query_template(@invalid_attrs)
    end

    test "update_query_template/2 with valid data updates the query_template" do
      query_template = query_template_fixture()
      update_attrs = %{name: "some updated name", query: "some updated query"}

      assert {:ok, %QueryTemplate{} = query_template} = QueryEngines.update_query_template(query_template, update_attrs)
      assert query_template.name == "some updated name"
      assert query_template.query == "some updated query"
    end

    test "update_query_template/2 with invalid data returns error changeset" do
      query_template = query_template_fixture()
      assert {:error, %Ecto.Changeset{}} = QueryEngines.update_query_template(query_template, @invalid_attrs)
      assert query_template == QueryEngines.get_query_template!(query_template.id)
    end

    test "delete_query_template/1 deletes the query_template" do
      query_template = query_template_fixture()
      assert {:ok, %QueryTemplate{}} = QueryEngines.delete_query_template(query_template)
      assert_raise Ecto.NoResultsError, fn -> QueryEngines.get_query_template!(query_template.id) end
    end

    test "change_query_template/1 returns a query_template changeset" do
      query_template = query_template_fixture()
      assert %Ecto.Changeset{} = QueryEngines.change_query_template(query_template)
    end
  end
end

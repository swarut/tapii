defmodule TapiiWeb.QueryTemplateGroupLiveTest do
  use TapiiWeb.ConnCase

  import Phoenix.LiveViewTest
  import Tapii.QueryEnginesFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp create_query_template_group(_) do
    query_template_group = query_template_group_fixture()
    %{query_template_group: query_template_group}
  end

  describe "Index" do
    setup [:create_query_template_group]

    test "lists all query_template_groups", %{conn: conn, query_template_group: query_template_group} do
      {:ok, _index_live, html} = live(conn, ~p"/query_template_groups")

      assert html =~ "Listing Query template groups"
      assert html =~ query_template_group.name
    end

    test "saves new query_template_group", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/query_template_groups")

      assert index_live |> element("a", "New Query template group") |> render_click() =~
               "New Query template group"

      assert_patch(index_live, ~p"/query_template_groups/new")

      assert index_live
             |> form("#query_template_group-form", query_template_group: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#query_template_group-form", query_template_group: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/query_template_groups")

      html = render(index_live)
      assert html =~ "Query template group created successfully"
      assert html =~ "some name"
    end

    test "updates query_template_group in listing", %{conn: conn, query_template_group: query_template_group} do
      {:ok, index_live, _html} = live(conn, ~p"/query_template_groups")

      assert index_live |> element("#query_template_groups-#{query_template_group.id} a", "Edit") |> render_click() =~
               "Edit Query template group"

      assert_patch(index_live, ~p"/query_template_groups/#{query_template_group}/edit")

      assert index_live
             |> form("#query_template_group-form", query_template_group: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#query_template_group-form", query_template_group: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/query_template_groups")

      html = render(index_live)
      assert html =~ "Query template group updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes query_template_group in listing", %{conn: conn, query_template_group: query_template_group} do
      {:ok, index_live, _html} = live(conn, ~p"/query_template_groups")

      assert index_live |> element("#query_template_groups-#{query_template_group.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#query_template_groups-#{query_template_group.id}")
    end
  end

  describe "Show" do
    setup [:create_query_template_group]

    test "displays query_template_group", %{conn: conn, query_template_group: query_template_group} do
      {:ok, _show_live, html} = live(conn, ~p"/query_template_groups/#{query_template_group}")

      assert html =~ "Show Query template group"
      assert html =~ query_template_group.name
    end

    test "updates query_template_group within modal", %{conn: conn, query_template_group: query_template_group} do
      {:ok, show_live, _html} = live(conn, ~p"/query_template_groups/#{query_template_group}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Query template group"

      assert_patch(show_live, ~p"/query_template_groups/#{query_template_group}/show/edit")

      assert show_live
             |> form("#query_template_group-form", query_template_group: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#query_template_group-form", query_template_group: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/query_template_groups/#{query_template_group}")

      html = render(show_live)
      assert html =~ "Query template group updated successfully"
      assert html =~ "some updated name"
    end
  end
end

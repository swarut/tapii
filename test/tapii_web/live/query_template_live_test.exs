defmodule TapiiWeb.QueryTemplateLiveTest do
  use TapiiWeb.ConnCase

  import Phoenix.LiveViewTest
  import Tapii.QueryEnginesFixtures

  @create_attrs %{name: "some name", query: "some query"}
  @update_attrs %{name: "some updated name", query: "some updated query"}
  @invalid_attrs %{name: nil, query: nil}

  defp create_query_template(_) do
    query_template = query_template_fixture()
    %{query_template: query_template}
  end

  describe "Index" do
    setup [:create_query_template]

    test "lists all query_templates", %{conn: conn, query_template: query_template} do
      {:ok, _index_live, html} = live(conn, ~p"/query_templates")

      assert html =~ "Listing Query templates"
      assert html =~ query_template.name
    end

    test "saves new query_template", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/query_templates")

      assert index_live |> element("a", "New Query template") |> render_click() =~
               "New Query template"

      assert_patch(index_live, ~p"/query_templates/new")

      assert index_live
             |> form("#query_template-form", query_template: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#query_template-form", query_template: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/query_templates")

      html = render(index_live)
      assert html =~ "Query template created successfully"
      assert html =~ "some name"
    end

    test "updates query_template in listing", %{conn: conn, query_template: query_template} do
      {:ok, index_live, _html} = live(conn, ~p"/query_templates")

      assert index_live |> element("#query_templates-#{query_template.id} a", "Edit") |> render_click() =~
               "Edit Query template"

      assert_patch(index_live, ~p"/query_templates/#{query_template}/edit")

      assert index_live
             |> form("#query_template-form", query_template: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#query_template-form", query_template: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/query_templates")

      html = render(index_live)
      assert html =~ "Query template updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes query_template in listing", %{conn: conn, query_template: query_template} do
      {:ok, index_live, _html} = live(conn, ~p"/query_templates")

      assert index_live |> element("#query_templates-#{query_template.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#query_templates-#{query_template.id}")
    end
  end

  describe "Show" do
    setup [:create_query_template]

    test "displays query_template", %{conn: conn, query_template: query_template} do
      {:ok, _show_live, html} = live(conn, ~p"/query_templates/#{query_template}")

      assert html =~ "Show Query template"
      assert html =~ query_template.name
    end

    test "updates query_template within modal", %{conn: conn, query_template: query_template} do
      {:ok, show_live, _html} = live(conn, ~p"/query_templates/#{query_template}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Query template"

      assert_patch(show_live, ~p"/query_templates/#{query_template}/show/edit")

      assert show_live
             |> form("#query_template-form", query_template: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#query_template-form", query_template: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/query_templates/#{query_template}")

      html = render(show_live)
      assert html =~ "Query template updated successfully"
      assert html =~ "some updated name"
    end
  end
end

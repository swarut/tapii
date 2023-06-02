defmodule TapiiWeb.SchedulerSubstitutionLiveTest do
  use TapiiWeb.ConnCase

  import Phoenix.LiveViewTest
  import Tapii.SchedulersFixtures

  @create_attrs %{key: "some key", value: "some value"}
  @update_attrs %{key: "some updated key", value: "some updated value"}
  @invalid_attrs %{key: nil, value: nil}

  defp create_scheduler_substitution(_) do
    scheduler_substitution = scheduler_substitution_fixture()
    %{scheduler_substitution: scheduler_substitution}
  end

  describe "Index" do
    setup [:create_scheduler_substitution]

    test "lists all scheduler_substitutions", %{conn: conn, scheduler_substitution: scheduler_substitution} do
      {:ok, _index_live, html} = live(conn, ~p"/scheduler_substitutions")

      assert html =~ "Listing Scheduler substitutions"
      assert html =~ scheduler_substitution.key
    end

    test "saves new scheduler_substitution", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/scheduler_substitutions")

      assert index_live |> element("a", "New Scheduler substitution") |> render_click() =~
               "New Scheduler substitution"

      assert_patch(index_live, ~p"/scheduler_substitutions/new")

      assert index_live
             |> form("#scheduler_substitution-form", scheduler_substitution: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#scheduler_substitution-form", scheduler_substitution: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/scheduler_substitutions")

      html = render(index_live)
      assert html =~ "Scheduler substitution created successfully"
      assert html =~ "some key"
    end

    test "updates scheduler_substitution in listing", %{conn: conn, scheduler_substitution: scheduler_substitution} do
      {:ok, index_live, _html} = live(conn, ~p"/scheduler_substitutions")

      assert index_live |> element("#scheduler_substitutions-#{scheduler_substitution.id} a", "Edit") |> render_click() =~
               "Edit Scheduler substitution"

      assert_patch(index_live, ~p"/scheduler_substitutions/#{scheduler_substitution}/edit")

      assert index_live
             |> form("#scheduler_substitution-form", scheduler_substitution: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#scheduler_substitution-form", scheduler_substitution: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/scheduler_substitutions")

      html = render(index_live)
      assert html =~ "Scheduler substitution updated successfully"
      assert html =~ "some updated key"
    end

    test "deletes scheduler_substitution in listing", %{conn: conn, scheduler_substitution: scheduler_substitution} do
      {:ok, index_live, _html} = live(conn, ~p"/scheduler_substitutions")

      assert index_live |> element("#scheduler_substitutions-#{scheduler_substitution.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#scheduler_substitutions-#{scheduler_substitution.id}")
    end
  end

  describe "Show" do
    setup [:create_scheduler_substitution]

    test "displays scheduler_substitution", %{conn: conn, scheduler_substitution: scheduler_substitution} do
      {:ok, _show_live, html} = live(conn, ~p"/scheduler_substitutions/#{scheduler_substitution}")

      assert html =~ "Show Scheduler substitution"
      assert html =~ scheduler_substitution.key
    end

    test "updates scheduler_substitution within modal", %{conn: conn, scheduler_substitution: scheduler_substitution} do
      {:ok, show_live, _html} = live(conn, ~p"/scheduler_substitutions/#{scheduler_substitution}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Scheduler substitution"

      assert_patch(show_live, ~p"/scheduler_substitutions/#{scheduler_substitution}/show/edit")

      assert show_live
             |> form("#scheduler_substitution-form", scheduler_substitution: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#scheduler_substitution-form", scheduler_substitution: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/scheduler_substitutions/#{scheduler_substitution}")

      html = render(show_live)
      assert html =~ "Scheduler substitution updated successfully"
      assert html =~ "some updated key"
    end
  end
end

defmodule TapiiWeb.SchedulerLiveTest do
  use TapiiWeb.ConnCase

  import Phoenix.LiveViewTest
  import Tapii.SchedulersFixtures

  @create_attrs %{active: true, occurence: 42, time: "14:00"}
  @update_attrs %{active: false, occurence: 43, time: "15:01"}
  @invalid_attrs %{active: false, occurence: nil, time: nil}

  defp create_scheduler(_) do
    scheduler = scheduler_fixture()
    %{scheduler: scheduler}
  end

  describe "Index" do
    setup [:create_scheduler]

    test "lists all schedulers", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/schedulers")

      assert html =~ "Listing Schedulers"
    end

    test "saves new scheduler", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/schedulers")

      assert index_live |> element("a", "New Scheduler") |> render_click() =~
               "New Scheduler"

      assert_patch(index_live, ~p"/schedulers/new")

      assert index_live
             |> form("#scheduler-form", scheduler: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#scheduler-form", scheduler: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/schedulers")

      html = render(index_live)
      assert html =~ "Scheduler created successfully"
    end

    test "updates scheduler in listing", %{conn: conn, scheduler: scheduler} do
      {:ok, index_live, _html} = live(conn, ~p"/schedulers")

      assert index_live |> element("#schedulers-#{scheduler.id} a", "Edit") |> render_click() =~
               "Edit Scheduler"

      assert_patch(index_live, ~p"/schedulers/#{scheduler}/edit")

      assert index_live
             |> form("#scheduler-form", scheduler: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#scheduler-form", scheduler: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/schedulers")

      html = render(index_live)
      assert html =~ "Scheduler updated successfully"
    end

    test "deletes scheduler in listing", %{conn: conn, scheduler: scheduler} do
      {:ok, index_live, _html} = live(conn, ~p"/schedulers")

      assert index_live |> element("#schedulers-#{scheduler.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#schedulers-#{scheduler.id}")
    end
  end

  describe "Show" do
    setup [:create_scheduler]

    test "displays scheduler", %{conn: conn, scheduler: scheduler} do
      {:ok, _show_live, html} = live(conn, ~p"/schedulers/#{scheduler}")

      assert html =~ "Show Scheduler"
    end

    test "updates scheduler within modal", %{conn: conn, scheduler: scheduler} do
      {:ok, show_live, _html} = live(conn, ~p"/schedulers/#{scheduler}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Scheduler"

      assert_patch(show_live, ~p"/schedulers/#{scheduler}/show/edit")

      assert show_live
             |> form("#scheduler-form", scheduler: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#scheduler-form", scheduler: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/schedulers/#{scheduler}")

      html = render(show_live)
      assert html =~ "Scheduler updated successfully"
    end
  end
end

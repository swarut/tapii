defmodule TapiiWeb.HistoryLiveTest do
  use TapiiWeb.ConnCase

  import Phoenix.LiveViewTest
  import Tapii.SchedulersFixtures

  @create_attrs %{result: %{}, status: :completed}
  @update_attrs %{result: %{}, status: :cancelled}
  @invalid_attrs %{result: nil, status: nil}

  defp create_history(_) do
    history = history_fixture()
    %{history: history}
  end

  describe "Index" do
    setup [:create_history]

    test "lists all histories", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/histories")

      assert html =~ "Listing Histories"
    end

    test "saves new history", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/histories")

      assert index_live |> element("a", "New History") |> render_click() =~
               "New History"

      assert_patch(index_live, ~p"/histories/new")

      assert index_live
             |> form("#history-form", history: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#history-form", history: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/histories")

      html = render(index_live)
      assert html =~ "History created successfully"
    end

    test "updates history in listing", %{conn: conn, history: history} do
      {:ok, index_live, _html} = live(conn, ~p"/histories")

      assert index_live |> element("#histories-#{history.id} a", "Edit") |> render_click() =~
               "Edit History"

      assert_patch(index_live, ~p"/histories/#{history}/edit")

      assert index_live
             |> form("#history-form", history: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#history-form", history: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/histories")

      html = render(index_live)
      assert html =~ "History updated successfully"
    end

    test "deletes history in listing", %{conn: conn, history: history} do
      {:ok, index_live, _html} = live(conn, ~p"/histories")

      assert index_live |> element("#histories-#{history.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#histories-#{history.id}")
    end
  end

  describe "Show" do
    setup [:create_history]

    test "displays history", %{conn: conn, history: history} do
      {:ok, _show_live, html} = live(conn, ~p"/histories/#{history}")

      assert html =~ "Show History"
    end

    test "updates history within modal", %{conn: conn, history: history} do
      {:ok, show_live, _html} = live(conn, ~p"/histories/#{history}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit History"

      assert_patch(show_live, ~p"/histories/#{history}/show/edit")

      assert show_live
             |> form("#history-form", history: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#history-form", history: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/histories/#{history}")

      html = render(show_live)
      assert html =~ "History updated successfully"
    end
  end
end

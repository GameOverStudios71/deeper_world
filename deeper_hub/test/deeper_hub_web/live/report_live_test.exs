defmodule DeeperHubWeb.ReportLiveTest do
  use DeeperHubWeb.ConnCase

  import Phoenix.LiveViewTest
  import DeeperHub.HubFixtures

  @create_attrs %{report_type: "some report_type", report_details: "some report_details", reported_at: "2025-06-20T18:00:00Z"}
  @update_attrs %{report_type: "some updated report_type", report_details: "some updated report_details", reported_at: "2025-06-21T18:00:00Z"}
  @invalid_attrs %{report_type: nil, report_details: nil, reported_at: nil}

  defp create_report(_) do
    report = report_fixture()
    %{report: report}
  end

  describe "Index" do
    setup [:create_report]

    test "lists all reports", %{conn: conn, report: report} do
      {:ok, _index_live, html} = live(conn, ~p"/reports")

      assert html =~ "Listing Reports"
      assert html =~ report.report_type
    end

    test "saves new report", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/reports")

      assert index_live |> element("a", "New Report") |> render_click() =~
               "New Report"

      assert_patch(index_live, ~p"/reports/new")

      assert index_live
             |> form("#report-form", report: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#report-form", report: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/reports")

      html = render(index_live)
      assert html =~ "Report created successfully"
      assert html =~ "some report_type"
    end

    test "updates report in listing", %{conn: conn, report: report} do
      {:ok, index_live, _html} = live(conn, ~p"/reports")

      assert index_live |> element("#reports-#{report.id} a", "Edit") |> render_click() =~
               "Edit Report"

      assert_patch(index_live, ~p"/reports/#{report}/edit")

      assert index_live
             |> form("#report-form", report: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#report-form", report: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/reports")

      html = render(index_live)
      assert html =~ "Report updated successfully"
      assert html =~ "some updated report_type"
    end

    test "deletes report in listing", %{conn: conn, report: report} do
      {:ok, index_live, _html} = live(conn, ~p"/reports")

      assert index_live |> element("#reports-#{report.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#reports-#{report.id}")
    end
  end

  describe "Show" do
    setup [:create_report]

    test "displays report", %{conn: conn, report: report} do
      {:ok, _show_live, html} = live(conn, ~p"/reports/#{report}")

      assert html =~ "Show Report"
      assert html =~ report.report_type
    end

    test "updates report within modal", %{conn: conn, report: report} do
      {:ok, show_live, _html} = live(conn, ~p"/reports/#{report}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Report"

      assert_patch(show_live, ~p"/reports/#{report}/show/edit")

      assert show_live
             |> form("#report-form", report: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#report-form", report: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/reports/#{report}")

      html = render(show_live)
      assert html =~ "Report updated successfully"
      assert html =~ "some updated report_type"
    end
  end
end

defmodule Tapii.SearchJobRequest do
  use Task
  require Logger

  def start_link(arg) do
    Task.start_link(__MODULE__, :run, [arg])
  end

  def run(arg) do
    Logger.info("[#{__MODULE__}] - Going to make a request - #{arg}")

    headers = ["Authorization": "Basic c3Vlc01CZEVvRHNUYnY6bVJyUklxUUJ1MERCd3FPdjNXaXNoZ2VxMEVYNmNjM3BpYnRJdlBkRFpNaHdRN0gzdlVRYlRxUDhWNmJkVG5LbA==", "Content-Type": "application/json"]
    url = "https://api.sumologic.com/api/v1/search/jobs"
    query = "\"tenjin-production\" \"elearning calculation finished\" | json \"data.parent_client_division_scheme_uuid\" as cds_uuid | count by cds_uuid"
    {:ok, data} = Poison.encode(%{query: query, from: "2023-07-26T01:00:00", to: "2023-07-26T01:03:00"})
    {:ok, resp} = HTTPoison.post(url, data, headers)
    {:ok, body} = resp.body |> Poison.decode

    Logger.info("[#{__MODULE__}] - Get search job created with id: #{body["id"]}, enqueueing job status checker")

    Tapii.SearchJobStatusChecker.start_link(body["id"])
  end
end

defmodule Tapii.SearchJobRequest do
  use Task
  require Logger

  alias Tapii.Schedulers

  def start_link(scheduler_id) do
    Task.start_link(__MODULE__, :run, [scheduler_id])
  end

  def run(scheduler_id) do
    scheduler = Schedulers.get_scheduler!(scheduler_id)
    Logger.info("[#{__MODULE__}] - Going to make a request - #{scheduler.id}")


    headers = ["Authorization": "Basic c3U3VGpNazFsa1pMb2M6WlA1WjN4eWVaUmRab1VHZEx0RG9CQ1NEVzZ5ZEFIS3Y4VUI4Y0ZGZm9HMGEzT1F5MzlkRnE0TXF4aTFkQ1Z5RQ==", "Content-Type": "application/json"]
    url = "https://api.sumologic.com/api/v1/search/jobs"
    # query = "\"tenjin-production\" \"elearning calculation finished\" | json \"data.parent_client_division_scheme_uuid\" as cds_uuid | count by cds_uuid"
    query = scheduler.query_template.query
    {:ok, data} = Poison.encode(%{query: query, from: "2023-12-24T01:00:00", to: "2023-12-24T04:00:00"})
    {:ok, resp} = HTTPoison.post(url, data, headers)
    {:ok, body} = resp.body |> Poison.decode

    Logger.info("[#{__MODULE__}] - Get search job created with id: #{body["id"]}, enqueueing job status checker")

    Tapii.SearchJobStatusChecker.start_link(body["id"], scheduler_id)
  end
end

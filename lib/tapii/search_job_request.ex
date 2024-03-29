defmodule Tapii.SearchJobRequest do
  use Task
  require Logger

  alias Tapii.Schedulers

  def start_link(auth_token, scheduler_id) do
    Task.start_link(__MODULE__, :run, [auth_token, scheduler_id])
  end

  def run(auth_token, scheduler_id) do
    scheduler = Schedulers.get_scheduler!(scheduler_id)
    Logger.info("[#{__MODULE__}] - Going to make a request - #{scheduler.id}")


    headers = ["Authorization": "Basic #{auth_token}", "Content-Type": "application/json"]
    url = "https://api.sumologic.com/api/v1/search/jobs"
    # query = "\"tenjin-production\" \"elearning calculation finished\" | json \"data.parent_client_division_scheme_uuid\" as cds_uuid | count by cds_uuid"
    query = scheduler.query_template.query
    {:ok, data} = Poison.encode(%{query: query, from: "2024-01-11T01:00:00", to: "2024-01-11T04:00:00"})
    {:ok, resp} = HTTPoison.post(url, data, headers)
    {:ok, body} = resp.body |> Poison.decode

    Logger.info("[#{__MODULE__}] - Get search job created with id: #{body["id"]}, enqueueing job status checker")

    Tapii.SearchJobStatusChecker.start_link(body["id"], auth_token, scheduler_id)
  end
end

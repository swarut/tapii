defmodule Tapii.SearchJobRetrieval do
  use Task
  require Logger

  alias Tapii.Schedulers

  def start_link(job_id) do
    Task.start_link(__MODULE__, :run, [job_id])
  end

  def run(job_id) do
    Logger.info("#{__MODULE__} - Retrieving result for job id #{job_id}")

    headers = ["Authorization": "Basic c3U3VGpNazFsa1pMb2M6WlA1WjN4eWVaUmRab1VHZEx0RG9CQ1NEVzZ5ZEFIS3Y4VUI4Y0ZGZm9HMGEzT1F5MzlkRnE0TXF4aTFkQ1Z5RQ==", "Content-Type": "application/json"]
    url = "https://api.sumologic.com/api/v1/search/jobs/#{job_id}/records?offset=0&limit=300"

    {:ok, resp} = HTTPoison.get(url, headers)
    {:ok, body} = resp.body |> Poison.decode

    Logger.info("[#{__MODULE__}] - Retrieved result for job #{job_id}: \n #{inspect(body["records"])}")
    Logger.info("[#{__MODULE__}] - Saving history")

    Schedulers.create_history(%{result: resp.body, status: :completed, scheduler_id: 1})
  end
end

defmodule Tapii.SearchJobStatusChecker do
  use Task
  require Logger

  def start_link(job_id) do
    Task.start_link(__MODULE__, :run, [job_id])
  end

  def run(job_id) do
    Logger.info("#{__MODULE__} - Checking search job status for job id #{job_id}")

    # Use Base.encode64("accesskey:secret") to generate the encoded token
    # headers = ["Authorization": "Basic c3UxazRIZno5OExkbFU6VEFrTTE0U1oyVE9jYUlMNDdENFZhV0Fvc1hwRTB1aXNrTmFZcUNNQ3Q5S3BjVDM0Q3lJQkE5QWdIWngwWWgwSQ==", "Content-Type": "application/json"]
    # url = "https://api.sumologic.com/api/v1/search/jobs/#{job_id}"

    # {:ok, resp} = HTTPoison.get(url, headers)
    # {:ok, body} = resp.body |> Poison.decode

    # Logger.info("[#{__MODULE__}] - Get search job #{job_id}'s status. #{body["state"]} ---")

    # case body["state"] do
    #   "DONE GATHERING RESULTS" ->
    #     Logger.info("Job #{job_id} is done.")
    #     Tapii.SearchJobRetrieval.start_link(job_id)
    #   "GATHERING RESULTS" ->
    #     Logger.info("Job #{job_id} is not yet done.")
    #     Process.sleep(10000)
    #     start_link(job_id)
    #   _ ->
    #     Logger.info("Job #{job_id} is having something wrong....")
    # end
  end
end

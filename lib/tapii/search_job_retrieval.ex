defmodule Tapii.SearchJobRetrieval do
  use Task
  require Logger

  alias Tapii.Schedulers

  def start_link(job_id, auth_token, scheduler_id) do
    Task.start_link(__MODULE__, :run, [job_id, auth_token, scheduler_id])
  end

  def run(job_id, auth_token, scheduler_id) do
    Logger.info("#{__MODULE__} - Retrieving result for job id #{job_id}, scheduler_id = #{scheduler_id}")

    headers = ["Authorization": "Basic #{auth_token}", "Content-Type": "application/json"]
    url = "https://api.sumologic.com/api/v1/search/jobs/#{job_id}/records?offset=0&limit=300"

    {:ok, resp} = HTTPoison.get(url, headers)
    {:ok, body} = resp.body |> Poison.decode

    Logger.info("[#{__MODULE__}] - Retrieved result for job #{job_id}: \n #{inspect(body["records"])}")
    Logger.info("[#{__MODULE__}] - Saving history")

    {:ok, history} = Schedulers.create_history(%{result: resp.body, status: :completed, scheduler_id: scheduler_id})
    Phoenix.PubSub.broadcast(Tapii.PubSub, "histories", {:new, history})
  end
end

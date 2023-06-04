defmodule Tapii.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Tapii.ScheduleExecutor, "aaa,bbb"},
      # Start the Telemetry supervisor
      TapiiWeb.Telemetry,
      # Start the Ecto repository
      Tapii.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Tapii.PubSub},
      # Start Finch
      {Finch, name: Tapii.Finch},
      # Start the Endpoint (http/https)
      TapiiWeb.Endpoint
      # Start a worker by calling: Tapii.Worker.start_link(arg)
      # {Tapii.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Tapii.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TapiiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

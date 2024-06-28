defmodule DietPro.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      DietProWeb.Telemetry,
      DietPro.Repo,
      {DNSCluster, query: Application.get_env(:diet_pro, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: DietPro.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: DietPro.Finch},
      # Start a worker by calling: DietPro.Worker.start_link(arg)
      # {DietPro.Worker, arg},
      # Start to serve requests, typically the last entry
      DietProWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DietPro.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    DietProWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

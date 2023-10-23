defmodule CommandedTest.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      CommandedTestWeb.Telemetry,
      CommandedTest.Repo,
      {DNSCluster, query: Application.get_env(:commanded_test, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: CommandedTest.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: CommandedTest.Finch},
      # Start a worker by calling: CommandedTest.Worker.start_link(arg)
      # {CommandedTest.Worker, arg},
      # Start to serve requests, typically the last entry
      CommandedTestWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CommandedTest.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CommandedTestWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

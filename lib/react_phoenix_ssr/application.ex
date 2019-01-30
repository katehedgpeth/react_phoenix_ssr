defmodule ReactPhoenixSsr.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      ReactPhoenixSsr.React,
      # Start the endpoint when the application starts
      ReactPhoenixSsrWeb.Endpoint
      # Starts a worker by calling: ReactPhoenixSsr.Worker.start_link(arg)
      # {ReactPhoenixSsr.Worker, arg},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ReactPhoenixSsr.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ReactPhoenixSsrWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

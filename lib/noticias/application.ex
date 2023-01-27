defmodule Noticias.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      NoticiasWeb.Telemetry,
      # Start the Ecto repository
      Noticias.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Noticias.PubSub},
      # Start Finch
      {Finch, name: Noticias.Finch},
      # Start the Endpoint (http/https)
      NoticiasWeb.Endpoint
      # Start a worker by calling: Noticias.Worker.start_link(arg)
      # {Noticias.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Noticias.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    NoticiasWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

defmodule MetaEvents.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  alias MetaEvents.EventBroker.Server, as: EventBrokerServer

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: MetaEvents.Worker.start_link(arg)
      # {MetaEvents.Worker, arg}
      {EventBrokerServer, name: EventBrokerServer.genserver_name()},
      MetaEvents.Repo
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MetaEvents.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

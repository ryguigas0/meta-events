defmodule MetaEvents.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  alias MetaEvents.EventBroker.Server, as: EventBrokerServer
  alias MetaEvents.EventPubSub.Server, as: EventPubSubServer

  @impl true
  def start(_type, _args) do
    children = [
      MetaEvents.Repo,
      {EventBrokerServer, name: EventBrokerServer.genserver_name()},
      {Phoenix.PubSub, name: EventPubSubServer.pubsub_name()},
      {EventPubSubServer, name: EventPubSubServer.genserver_name()}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MetaEvents.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

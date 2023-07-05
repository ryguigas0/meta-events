defmodule MetaEvents.EventPubSub.Server do
  alias Phoenix.PubSub

  require Logger

  use GenServer

  import MetaEvents.Util.Parser.ListenerModule

  def pubsub_name, do: :meta_events_pubsub

  def genserver_name, do: MetaEvents.EventPubSub.Server

  def event_topic_name, do: "events"

  @impl true
  def init(_) do
    :ok = PubSub.subscribe(pubsub_name(), event_topic_name())

    {:ok, nil}
  end

  def start_link(opts) do
    Logger.info("#{__MODULE__} STARTING")

    result = GenServer.start_link(__MODULE__, [], opts)

    Logger.info("#{__MODULE__} STARTED")

    result
  end

  @impl true
  def handle_info(event, _) do
    get_listener_modules!()
    |> Enum.filter(&should_listen?(&1, event.name))
    |> Enum.each(&trigger_listener(&1, event))

    {:noreply, nil}
  end

  defp should_listen?(listener_module, event_name),
    do: listener_module.listen?(event_name)

  defp trigger_listener(listener_module, event) do
    listener_module.call(event)
  end
end

defmodule MetaEvents.EventPubSub.Client do
  alias Phoenix.PubSub

  import MetaEvents.EventPubSub.Server, only: [pubsub_name: 0, event_topic_name: 0]

  def broadcast_event(event) do
    PubSub.broadcast(
      pubsub_name(),
      event_topic_name(),
      event
    )
  end
end

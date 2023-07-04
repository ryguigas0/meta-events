defmodule MetaEvents.EventBroker.Client do
  import MetaEvents.EventBroker.Server, only: [genserver_name: 0]

  @doc """
  Shows EventBroker's recorded events
  """
  def get_history do
    GenServer.call(genserver_name(), :event_history)
  end

  @typedoc """
  Necessary event data
  """
  @type event :: %{name: binary(), payload: map(), emmiter: atom()}

  @doc """
  Emmits an event to the EventBroker genserver

  ## Example
    iex> event = %{name: "Hello", payload: %{message: "Hello, my name is: "}, emmiter: "guilherme"}

    iex> MetaEvents.EventBroker.Client.emmit_event(event)

    :ok
  """
  @spec emmit_event(event()) :: :ok
  def emmit_event(event) do
    GenServer.cast(genserver_name(), {:emmit_event, event})
  end
end

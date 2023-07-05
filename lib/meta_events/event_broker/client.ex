defmodule MetaEvents.EventBroker.Client do
  import MetaEvents.EventBroker.Server, only: [genserver_name: 0]

  @doc """
  Shows EventBroker's recorded events
  """
  def get_history do
    GenServer.call(genserver_name(), :event_history)
  end

  @doc """
  Emmits an event to the EventBroker genserver

  ## Example
    iex> event = %{name: "Events.Hello", payload: %{"message" => "Hello, my name is: "}, emmiter: "guilherme"}

    iex> MetaEvents.EventBroker.Client.emmit_event(event)
  """
  @spec emmit_event(%{
          name: String.t(),
          payload: %{optional(String.t()) => any()},
          emmiter: String.t()
        }) :: :ok | {:error, atom()}
  def emmit_event(event) do
    GenServer.call(genserver_name(), {:emmit_event, event})
  end
end

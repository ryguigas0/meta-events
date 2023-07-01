defmodule MetaEvents.EventBroker do
  # SERVER API
  use GenServer

  @initial_event_history []

  @impl true
  def init(_) do
    {:ok, @initial_event_history}
  end

  @impl true
  def handle_call(:event_history, _emmiter, event_history) do
    {:reply, event_history, event_history}
  end

  @impl true
  def handle_cast({:emmit_event, event_name, payload}, event_history) do
    result =
      event_name
      |> EventParser.parse_event_name_to_module()
      |> handle_event_module(payload)

    updated_event_history = event_history ++ [{event_name, payload, result}]

    {:noreply, updated_event_history}
  end

  defp handle_event_module({:error, _reason} = err, _), do: err

  defp handle_event_module({:ok, event_module}, payload) do
    try do
      Task.start_link(fn ->
        event_module.call(payload)
      end)
    rescue
      _e in UndefinedFunctionError -> {:error, :undefined_event}
    end
  end

  # CLIENT API
  require Logger

  def start_link(opts) do
    Logger.info("#{__MODULE__} STARTING")

    result = GenServer.start_link(__MODULE__, [], opts)

    Logger.info("#{__MODULE__} STARTED")

    result
  end

  def get_history do
    GenServer.call(__MODULE__, :event_history)
  end

  def emmit_event(event_name, payload) do
    GenServer.cast(__MODULE__, {:emmit_event, event_name, payload})
  end
end

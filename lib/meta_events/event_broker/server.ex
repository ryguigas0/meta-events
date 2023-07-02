defmodule MetaEvents.EventBroker.Server do
  use GenServer

  require Logger

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
  def handle_cast(
        {:emmit_event, %{name: event_name, payload: payload, emmiter: emmiter}},
        event_history
      ) do
    result =
      event_name
      |> EventParser.parse_event_name_to_module()
      |> handle_event_module(payload, emmiter)

    updated_event_history = event_history ++ [{event_name, payload, result}]

    {:noreply, updated_event_history}
  end

  defp handle_event_module({:error, _reason} = err, _, _), do: err

  defp handle_event_module({:ok, event_module}, payload, emmiter) do
    try do
      Task.start_link(fn ->
        event_module.call(payload, emmiter)
      end)
    rescue
      _e in UndefinedFunctionError -> {:error, :undefined_event}
    end
  end

  def start_link(opts) do
    Logger.info("#{__MODULE__} STARTING")

    result = GenServer.start_link(__MODULE__, [], opts)

    Logger.info("#{__MODULE__} STARTED")

    result
  end

  def genserver_name, do: MetaEvents.EventBroker
end

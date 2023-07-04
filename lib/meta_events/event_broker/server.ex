defmodule MetaEvents.EventBroker.Server do
  use GenServer

  require Logger

  alias MetaEvents.EventSchema

  import MetaEvents.Util.EventParser
  import MetaEvents.Util.EventHandler

  @genserver_state nil

  @impl true
  def init(_) do
    {:ok, @genserver_state}
  end

  @impl true
  def handle_call(:event_history, _emmiter, _) do
    event_history = EventSchema.list()
    {:reply, event_history, @genserver_state}
  end

  @impl true
  def handle_cast(
        {:emmit_event, event},
        _
      ) do
    event
    |> EventSchema.insert()
    |> handle_insert_schema()
  end

  defp handle_insert_schema({:ok, event}) do
    event.name
    |> parse_event_name_to_module()
    |> handle_event_module(event.payload, event.emmiter, event.id)
  end

  defp handle_insert_schema({:error, _invalid_changeset} = err), do: err

  defp handle_event_module({:error, _reason} = err, _, _, _), do: err

  defp handle_event_module({:ok, event_module}, payload, emmiter, event_id) do
    Task.start_link(fn ->
      try do
        payload
        |> event_module.call(emmiter)
      rescue
        UndefinedFunctionError ->
          {:error, :undefined_event}
      end
      |> handle_event_result(event_id)
    end)

    {:noreply, @genserver_state}
  end

  def start_link(opts) do
    Logger.info("#{__MODULE__} STARTING")

    result = GenServer.start_link(__MODULE__, [], opts)

    Logger.info("#{__MODULE__} STARTED")

    result
  end

  def genserver_name, do: MetaEvents.EventBroker
end

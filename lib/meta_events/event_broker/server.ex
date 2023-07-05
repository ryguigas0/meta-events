defmodule MetaEvents.EventBroker.Server do
  @moduledoc false

  use GenServer

  require Logger

  alias MetaEvents.EventSchema

  import MetaEvents.Util.Parser.EventModule
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
  def handle_call(
        {:emmit_event, event},
        _,
        _
      ) do
    event
    |> EventSchema.insert()
    |> handle_insert_schema()
    |> create_response()
  end

  defp create_response(result), do: {:reply, result, @genserver_state}

  defp handle_insert_schema({:ok, event}) do
    event.name
    |> parse_event_name_to_module()
    |> handle_event_module(event)
  end

  defp handle_insert_schema({:error, _invalid_changeset} = err), do: err

  defp handle_event_module({:error, _reason} = err, _), do: err

  defp handle_event_module({:ok, event_module}, event) do
    Task.start_link(fn ->
      try do
        event.payload
        |> event_module.call(event.emmiter)
      rescue
        UndefinedFunctionError ->
          {:error, :undefined_event}
      end
      |> handle_event_result(event)
    end)

    :ok
  end

  def start_link(opts) do
    Logger.info("#{__MODULE__} STARTING")

    result = GenServer.start_link(__MODULE__, [], opts)

    Logger.info("#{__MODULE__} STARTED")

    result
  end

  def genserver_name, do: MetaEvents.EventBroker
end

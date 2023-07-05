defmodule MetaEvents.Modules.Listener.Logger do
  @behaviour ListenerBehaviour

  require Logger

  @impl true
  def listen?(_), do: true

  @impl true
  def call(event) do
    event
    |> generate_log()
    |> handle_message()
  end

  defp generate_log(event) do
    [status, output] =
      event.result
      |> String.split(": ", trim: true)

    message = generate_message(event.name, event.emmiter, output)

    case status do
      "finished" ->
        {:info, message}

      "error" ->
        {error_level(output), message}
    end
  end

  defp generate_message(event_name, emmiter, output),
    do: event_name <> " called by " <> emmiter <> " => " <> output

  defp error_level(error_type) do
    error_type
    |> String.to_existing_atom()
    |> case do
      :undefined_event ->
        :alert

      :invalid_payload ->
        :error

      _ ->
        :warn
    end
  end

  @logger_levels [:emergency, :alert, :critical, :error, :warning, :warn, :notice, :info, :debug]

  defp handle_message({level, msg}) when level in @logger_levels do
    Logger.bare_log(level, msg)
  end
end

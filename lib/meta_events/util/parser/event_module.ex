defmodule MetaEvents.Util.Parser.EventModule do
  @event_name_regex ~r/([A-Z][a-z]+\.?)*/

  def parse_event_name_to_module(event_name) do
    event_name
    |> validate_event_name()
    |> handle_event_name(event_name)
  end

  defp validate_event_name(event_name) when is_binary(event_name) do
    event_name
    |> String.match?(@event_name_regex)
    |> if do
      :ok
    else
      {:error, :event_name_invalid_format}
    end
  end

  defp validate_event_name(_), do: {:error, :event_name_not_string}

  defp handle_event_name({:error, _reason} = err, _), do: err

  defp handle_event_name(:ok, event_name) do
    event_path = ["MetaEvents", "Modules", "Events"] ++ String.split(event_name, ".", trim: true)

    event_module = Module.concat(event_path)

    {:ok, event_module}
  end
end

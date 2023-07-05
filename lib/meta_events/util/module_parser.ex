defmodule MetaEvents.Util.ModuleParser do
  @event_name_regex ~r/([A-Z][a-z]+\.?)*/

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

  def parse_event_name_to_module(event_name) do
    event_name
    |> validate_event_name()
    |> handle_validation(event_name)
  end

  defp handle_validation({:error, _reason} = err, _), do: err

  defp handle_validation(:ok, event_name) do
    event_path = ["MetaEvents", "Modules"] ++ String.split(event_name, ".", trim: true)

    event_module = Module.concat(event_path)

    {:ok, event_module}
  end
end

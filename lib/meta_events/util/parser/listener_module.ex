defmodule MetaEvents.Util.Parser.ListenerModule do
  def get_listener_modules! do
    case :application.get_key(:meta_events, :modules) do
      {:ok, modules} ->
        Enum.filter(modules, &is_listener_module?/1)

      {:error, _} ->
        throw("ERROR GETTING APPLICATION MODULES")
    end
  end

  defp is_listener_module?(module) do
    module
    |> Module.split()
    |> Enum.any?(&String.equivalent?(&1, "Listener"))
  end
end

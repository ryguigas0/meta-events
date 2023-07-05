defmodule MetaEvents.Modules.Events.EchoDelayed do
  @moduledoc """
  Echoes the value of `message` after `delay` milliseconds
  """
  @behaviour EventBehaviour

  @impl true
  def call(%{"message" => message, "delay" => delay}, _) do
    Process.sleep(delay)

    IO.puts(message)
  end

  @impl true
  def call(_, _), do: {:error, :invalid_payload}
end

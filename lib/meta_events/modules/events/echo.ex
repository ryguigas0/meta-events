defmodule MetaEvents.Modules.Events.Echo do
  @moduledoc """
  Echoes the value of `message`
  """
  @behaviour EventBehaviour

  @impl true
  def call(%{"message" => message}, _) do
    IO.puts(message)
  end

  @impl true
  def call(_, _), do: {:error, :invalid_payload}
end

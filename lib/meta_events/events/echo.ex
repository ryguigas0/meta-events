defmodule MetaEvents.Events.Echo do
  @behaviour EventBehaviour

  @impl true
  def call(%{message: message}), do: IO.puts(message)

  @impl true
  def call(_), do: {:error, :invalid_payload}
end

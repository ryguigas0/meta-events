defmodule MetaEvents.Modules.Echo do
  @behaviour EventBehaviour

  @impl true
  def call(%{message: message}, _), do: IO.puts(message)

  @impl true
  def call(_, _), do: {:error, :invalid_payload}
end

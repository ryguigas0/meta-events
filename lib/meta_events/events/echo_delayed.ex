defmodule MetaEvents.Events.EchoDelayed do
  @behaviour EventBehaviour

  @impl true
  def call(%{message: message, delay: delay}, _) do
    Process.sleep(delay)

    IO.puts(message)
  end

  @impl true
  def call(_, _), do: {:error, :invalid_payload}
end

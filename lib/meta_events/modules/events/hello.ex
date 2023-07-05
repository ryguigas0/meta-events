defmodule MetaEvents.Modules.Events.Hello do
  @moduledoc """
  Says hello to the emmiter
  """
  @behaviour EventBehaviour

  def call(%{"message" => message}, emmiter) do
    IO.puts(message <> "#{emmiter}")
  end

  def call(%{}, emmiter) do
    IO.puts("Hello #{emmiter}!")
  end

  @impl true
  def call(_, _), do: {:error, :invalid_payload}
end

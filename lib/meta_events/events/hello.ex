defmodule MetaEvents.Events.Hello do
  @behaviour EventBehaviour

  def call(%{message: message}, emmiter) do
    IO.puts(message <> "#{emmiter}")
  end

  def call(%{}, emmiter) do
    IO.puts("Hello #{emmiter}!")
  end
end

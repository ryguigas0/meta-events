defmodule MetaEvents.Util.EventHandler do
  @moduledoc false

  alias MetaEvents.EventSchema

  def handle_event_result(:ok, event) do
    update_event("finished: ok", event.id)
  end

  def handle_event_result({:ok, atom}, event) do
    atom_string = Atom.to_string(atom)

    update_event("finished: #{atom_string}", event.id)
  end

  def handle_event_result({:error, atom}, event) do
    atom_string = Atom.to_string(atom)

    update_event("error: #{atom_string}", event.id)
  end

  defp update_event(result, event_id) do
    EventSchema.update!(%{result: result}, event_id)
  end
end

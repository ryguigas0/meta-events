defmodule MetaEvents.Util.EventHandler do
  @moduledoc false

  alias MetaEvents.EventSchema

  def handle_event_result(:ok, event_id),
    do: EventSchema.update!(%{result: "finished: ok"}, event_id)

  def handle_event_result({:ok, atom}, event_id) do
    atom_string = Atom.to_string(atom)

    EventSchema.update!(%{result: "finished: #{atom_string}"}, event_id)
  end

  def handle_event_result({:error, atom}, event_id) do
    atom_string = Atom.to_string(atom)

    EventSchema.update!(%{result: "error: #{atom_string}"}, event_id)
  end
end

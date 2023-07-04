defmodule MetaEventsTest.EventBroker.EmmitEventTest do
  use ExUnit.Case, async: true

  alias MetaEvents.EventBroker.Client

  setup do
    %{
      ok_event: %{name: "Echo", payload: %{"message" => "This is an message"}},
      bad_name: %{name: "DoesNotExists", payload: %{}}
    }
  end

  test "Errors on undefined event", %{bad_name: %{payload: event_payload} = event} do
    assert :ok = Client.emmit_event(event)

    # Waits for event to finish
    Process.sleep(100)

    event_from_history = find_event_on_list(Client.get_history(), event.name)

    refute is_nil(event_from_history)

    assert %{
             emmiter: "anon",
             id: _,
             inserted_at: _,
             name: "DoesNotExists",
             payload: ^event_payload,
             result: "error: undefined_event"
           } = event_from_history
  end

  test "Emmits valid events", %{ok_event: %{payload: event_payload} = event} do
    assert :ok = Client.emmit_event(event)

    # Waits for event to finish
    Process.sleep(100)

    event_from_history = find_event_on_list(Client.get_history(), event.name)

    refute is_nil(event_from_history)

    assert %{
             emmiter: "anon",
             id: _,
             inserted_at: _,
             name: "Echo",
             payload: ^event_payload,
             result: _
           } = event_from_history
  end

  defp find_event_on_list(list, name) do
    Client.get_history()
    |> Enum.find_value(fn e ->
      if String.equivalent?(name, e.name) do
        e
      end
    end)
  end
end

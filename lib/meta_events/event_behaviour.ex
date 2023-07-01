defmodule EventBehaviour do
  @type ok_result :: {:ok, atom()} | {:ok, keyword()} | :ok

  @type error_result :: {:error, atom()} | {:error, keyword()}

  @type event_payload :: %{args: list()}

  @callback call(payload :: event_payload) :: ok_result | error_result
end

defmodule EventBehaviour do
  @type ok_result :: {:ok, atom()} | :ok

  @type error_result :: {:error, atom()}

  @callback call(payload :: map(), emmiter :: atom()) :: ok_result | error_result
end

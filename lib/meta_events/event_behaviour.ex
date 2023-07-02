defmodule EventBehaviour do
  @type ok_result :: {:ok, atom()} | {:ok, keyword()} | :ok

  @type error_result :: {:error, atom()} | {:error, keyword()}

  @callback call(payload :: map(), emmiter :: atom()) :: ok_result | error_result
end

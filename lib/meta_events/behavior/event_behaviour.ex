defmodule EventBehaviour do
  @moduledoc """
  Describes events input and outcomes
  """

  @typedoc """
  Represents possible ok results
  """
  @type ok_result :: {:ok, atom()} | :ok

  @typedoc """
  Represents possible error results
  """
  @type error_result :: {:error, atom()}

  @doc """
  The function the event runs
  """
  @callback call(payload :: map(), emmiter :: atom()) :: ok_result | error_result
end

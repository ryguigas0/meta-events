defmodule EventBehaviour do
  @moduledoc """
  Describes events input and outcomes
  """

  @doc """
  The function the event runs
  """
  @callback call(payload :: %{optional(String.t()) => any()}, emmiter :: String.t()) ::
              :ok | {:ok, atom()} | {:error, atom()}
end

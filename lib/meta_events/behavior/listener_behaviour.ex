defmodule ListenerBehaviour do
  @moduledoc """
  Describes listeners input and outcomes
  """

  @doc """
  The function that the listener runs
  """
  @callback call(event :: %{String.t() => any()}) ::
              :ok | {:ok, atom()} | {:error, atom()}

  @doc """
  If `listen?` returns true, then the listener module is triggered
  """
  @callback listen?(event_name :: String.t()) :: true | false
end

defmodule MetaEvents.Repo do
  use Ecto.Repo,
    otp_app: :meta_events,
    adapter: Ecto.Adapters.SQLite3
end

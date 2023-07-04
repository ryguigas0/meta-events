import Config

config :meta_events,
  ecto_repos: [MetaEvents.Repo]

import_config "#{Mix.env()}.exs"

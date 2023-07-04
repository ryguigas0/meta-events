import Config

config :meta_events, MetaEvents.Repo,
  database: System.get_env("DB_PATH", "./database.db"),
  migration_primary_key: [
    name: :id,
    type: :binary_id,
    autogenerate: true
  ]

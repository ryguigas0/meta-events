import Config

config :meta_events, MetaEvents.Repo,
  database: "./test-database.db",
  migration_primary_key: [
    name: :id,
    type: :binary_id,
    autogenerate: true
  ]

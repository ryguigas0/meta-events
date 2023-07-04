import Config

config :meta_events,
  ecto_repos: [MetaEvents.Repo]

db_path = System.get_env("DB_PATH", "./database.db")

if not File.exists?(db_path) do
  File.write!(db_path, "")
end

config :meta_events, MetaEvents.Repo,
  database: db_path,
  migration_primary_key: [
    name: :id,
    type: :binary_id,
    autogenerate: true
  ]

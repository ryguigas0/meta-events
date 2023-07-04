defmodule MetaEvents.Repo.Migrations.CreateEventLedger do
  use Ecto.Migration

  def change do
    create_if_not_exists table(:event, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :emmiter, :string, null: true
      add :payload, :map, null: true
      add :result, :string, null: true

      timestamps(updated_at: false)
    end
  end
end

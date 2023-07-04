defmodule MetaEvents.EventSchema do
  use Ecto.Schema

  import Ecto.Changeset
  # import Ecto.Query

  alias MetaEvents.Repo

  @required_fields [:name]

  @all_fields @required_fields ++ [:emmiter, :payload, :result]

  @event_name_regex ~r/([A-Z][a-z]+\.?)*/

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "event" do
    field(:name, :string)
    field(:emmiter, :string, default: "anon")
    field(:payload, :map)
    field(:result, :string, default: "unfinished")

    timestamps(updated_at: false)
  end

  def changeset(%__MODULE__{} = event, changes, type \\ :insert) do
    case type do
      :insert ->
        insert_changeset(event, changes)

      :update ->
        update_changeset(event, changes)
    end
  end

  defp insert_changeset(event, changes) do
    event
    |> cast(changes, @all_fields)
    |> validate_required(@required_fields)
    |> validate_format(:name, @event_name_regex)
    |> validate_length(:emmiter, max: 30)
  end

  defp update_changeset(event, changes) do
    event
    |> cast(changes, @all_fields)
    |> validate_format(:name, @event_name_regex)
    |> validate_length(:emmiter, max: 30)
  end

  def insert(changes) do
    %__MODULE__{}
    |> changeset(changes, :insert)
    |> Repo.insert()
  end

  def update(changes, event_id) do
    case Repo.get(__MODULE__, event_id) do
      {:ok, event} ->
        event
        |> changeset(changes, :update)
        |> Repo.update()

      {:error, _} ->
        {:error, :event_not_found}
    end
  end

  def update!(changes, event_id) do
    Repo.get!(__MODULE__, event_id)
    |> changeset(changes, :update)
    |> Repo.update!()
  end

  def list do
    # query = from(e in __MODULE__, order_by: [desc: e.inserted_at])

    # Repo.all(query)

    Repo.all(__MODULE__)
  end
end

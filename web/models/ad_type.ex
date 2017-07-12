defmodule Poster.AdType do
  use Poster.Web, :model

  schema "types" do
    field :status, :boolean
    field :name, :string
    field :description, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:adtype_id, :status, :name, :description])
    |> validate_required([:adtype_id, :name, :description])
  end

  def alphabetical(query) do
    from t in query, order_by: t.name
  end

  def names_and_ids(query) do
    from t in query, where: [status: true], select: {t.name, t.id}
  end

end

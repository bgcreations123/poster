defmodule Poster.Categories do
  use Poster.Web, :model

  alias Poster.Repo

  schema "categories" do
    field :parent_id, :string
    field :status, :boolean
    field :name, :string
    field :description, :string

    belongs_to :ad_type, Poster.AdType, foreign_key: :adtype_id

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:adtype_id, :parent_id, :status, :name, :description])
    |> validate_required([:name, :description])
  end

  def alphabetical(query) do
    from c in query, order_by: c.name
  end

  def names_and_ids(query) do
    from c in query, where: [parent_id: "null", status: true], select: {c.name, c.id}
  end

  def get_and_preload_adtype(id) do
    from(q in __MODULE__, where: q.id == ^id,
    join: t in assoc(q, :ad_type),
    preload: [ad_type: t])
    |> Repo.one!()
  end

end

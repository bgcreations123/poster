defmodule Poster.Posts do
  use Poster.Web, :model
  use Ecto.Schema

  alias Poster.Repo

  schema "posts" do
    field :status, :boolean
    field :title, :string
    field :content, :string
    field :price, :float

    belongs_to :categories, Poster.Categories, foreign_key: :categories_id
    belongs_to :locations, Poster.Locations, foreign_key: :location_id
    #belongs_to :users, Poster.Users, foreign_key: :user_id
    belongs_to :ad_type, Poster.AdType, foreign_key: :adtype_id

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:adtype_id, :categories_id, :location_id, :status, :title, :content, :price])
    |> validate_required([:categories_id, :title, :content, :price])
  end

  def get_and_preload_category_and_adtypes(id) do
    from(q in __MODULE__, where: q.id == ^id,
    join: c in assoc(q, :categories),
    join: l in assoc(q, :locations),
    join: t in assoc(q, :ad_type),
    preload: [categories: c],
    preload: [locations: l],
    preload: [ad_type: t])
    |> Repo.one!()
  end
end

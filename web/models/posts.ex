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

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:categories_id, :status, :title, :content, :price])
    |> validate_required([:categories_id, :title, :content, :price])
  end

  def get_and_preload_category(id) do
    from(q in __MODULE__, where: q.id == ^id,
    join: c in assoc(q, :categories),
    preload: [categories: c])
    |> Repo.one!()
  end
end

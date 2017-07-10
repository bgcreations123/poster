defmodule Poster.Categories do
  use Poster.Web, :model

  schema "categories" do
    field :parent_id, :string
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
    |> cast(params, [:parent_id, :status, :name, :description])
    |> validate_required([:name, :description])
  end

  def alphabetical(query) do
    from c in query, order_by: c.name
  end

  def names_and_ids(query) do
    from c in query, where: [parent_id: "null", status: true], select: {c.name, c.id}
  end
end

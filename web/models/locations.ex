defmodule Poster.Locations do
  use Poster.Web, :model

  schema "locations" do
    field :status, :boolean
    field :name, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:status, :name])
    |> validate_required([:name])
  end
end

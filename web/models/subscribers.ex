defmodule Poster.Subscribers do
  use Poster.Web, :model

  schema "subscribers" do
    belongs_to :users, Poster.Users, foreign_key: :user_id
    belongs_to :locations, Poster.Locations, foreign_key: :location_id

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:user_id, :location_id])
  end
end

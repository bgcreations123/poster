defmodule Poster.MeLocationTest do
  use Poster.ModelCase

  alias Poster.MeLocation

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = MeLocation.changeset(%MeLocation{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = MeLocation.changeset(%MeLocation{}, @invalid_attrs)
    refute changeset.valid?
  end
end

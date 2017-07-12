defmodule Poster.MeTypeTest do
  use Poster.ModelCase

  alias Poster.MeType

  @valid_attrs %{description: "some content", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = MeType.changeset(%MeType{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = MeType.changeset(%MeType{}, @invalid_attrs)
    refute changeset.valid?
  end
end

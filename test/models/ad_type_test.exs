defmodule Poster.AdTypeTest do
  use Poster.ModelCase

  alias Poster.AdType

  @valid_attrs %{description: "some content", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = AdType.changeset(%AdType{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = AdType.changeset(%AdType{}, @invalid_attrs)
    refute changeset.valid?
  end
end

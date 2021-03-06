defmodule Poster.PostsTest do
  use Poster.ModelCase

  alias Poster.Posts

  @valid_attrs %{content: "some content", price: "120.5", title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Posts.changeset(%Posts{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Posts.changeset(%Posts{}, @invalid_attrs)
    refute changeset.valid?
  end
end

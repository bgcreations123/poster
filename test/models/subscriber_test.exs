defmodule Poster.SubscriberTest do
  use Poster.ModelCase

  alias Poster.Subscriber

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Subscriber.changeset(%Subscriber{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Subscriber.changeset(%Subscriber{}, @invalid_attrs)
    refute changeset.valid?
  end
end

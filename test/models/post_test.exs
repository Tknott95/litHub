defmodule LitHub.PostTest do
  use LitHub.ModelCase

  alias LitHub.Post

  @valid_attrs %{author: "some content", category: "some content", content: "some content", date_published: %{day: 17, month: 4, year: 2010}, published: true, title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Post.changeset(%Post{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Post.changeset(%Post{}, @invalid_attrs)
    refute changeset.valid?
  end
end

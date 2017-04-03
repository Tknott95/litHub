defmodule LitHub.Blog do
  use LitHub.Web, :model

  schema "blog_posts" do
    field :title, :string
    field :author, :string
    field :category, :string
    field :content, :string

    belongs_to :user, LitHub.User
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :author, :category, :content])
    |> validate_required([:title, :author, :category, :content])
  end
end

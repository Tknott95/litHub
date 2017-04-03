defmodule LitHub.User do
  use LitHub.Web, :model

  schema "users" do
    field :email, :string
    field :provider, :string
    field :token, :string
    has_many :topics, LitHub.Topic
    has_many :comments, LitHub.Comment
    has_many :blog_posts, LitHub.BlogPost

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email, :provider, :token])
    |> validate_required([:email, :provider, :token])
  end
end

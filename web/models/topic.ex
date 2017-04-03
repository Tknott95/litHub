defmodule LitHub.Topic do
  use LitHub.Web, :model

  schema "topics" do
    field :title, :string
    belongs_to :user, LitHub.User
    has_many :comments, LitHub.Comment
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title])
    |> validate_required([:title])
  end
end

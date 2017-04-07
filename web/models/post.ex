defmodule LitHub.Post do
  use LitHub.Web, :model

  schema "posts" do
    field :title, :string
    field :category, :string
    field :content, :string
    field :author, :string
    field :date_published, Ecto.Date
    field :published, :boolean, default: false

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :category, :content, :author, :date_published, :published])
    |> validate_required([:title, :category, :content, :author, :date_published, :published])
  end
end

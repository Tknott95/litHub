defmodule LitHub.Comment do
  use LitHub.Web, :model

  schema "comments" do
     field :content, :string
     belongs_to :user, LitHub.User
     belongs_to :topic, Lithub.Topic

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:content])
    |> validate_required([:content])
  end
end

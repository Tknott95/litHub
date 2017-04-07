defmodule LitHub.Repo.Migrations.CreatePost do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :category, :string
      add :content, :string
      add :author, :string
      add :date_published, :date
      add :published, :boolean, default: false, null: false

      timestamps()
    end

  end
end

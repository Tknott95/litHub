defmodule LitHub.Repo.Migrations.AddBlogPosts do
  use Ecto.Migration

  def change do
   create table(:blog_posts) do
      add :title, :string
      add :author, :string
      add :category, :string
      add :content, :string
      add :user_id, references(:users)

      timestamps()
   end
  end
end

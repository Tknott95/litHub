defmodule LitHub.BlogController do
  use LitHub.Web, :controller

  alias LitHub.Blog

   def index(conn, _params) do
    IO.inspect(conn.assigns)
    blog_posts = Repo.all(Blog)

    render conn, "index.html", blog_posts: blog_posts
  end

  def new(conn, _params) do
    changeset = Blog.changeset(%Blog{}, %{})
    {:error, changeset} = Repo.insert(changeset)

    render conn, "new.html", changeset: changeset
  end

   def create(conn, _params) do  # %{"title" => title,"author" => author, "category" => category, "content" => content]
    changeset = conn.assigns.user
      |> build_assoc(:blog_posts)   # looks into users model ands sees has_many
      |> Blog.changeset(_params)

    case Repo.insert(changeset) do
      {:ok, _blog_post} -> 
        conn
        |> put_flash(:info, "Blog Post Created")
        |> redirect(to: blog_path(conn, :index))
      {:error, changeset} -> 
        render conn, "new.html", changeset: changeset
    end
  end
end

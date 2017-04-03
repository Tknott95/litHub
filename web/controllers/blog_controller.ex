defmodule LitHub.BlogController do
  use LitHub.Web, :controller

  alias LitHub.Blog

   def index(conn, _params) do
    IO.inspect(conn.assigns)
    topics = Repo.all(Blog)

    render conn, "index.html", topics: topics
  end

  def new(conn, _params) do
    changeset = Blog.changeset(%Blog{}, %{})
    {:error, changeset} = Repo.insert(changeset)

    render conn, "new.html", changeset: changeset
  end

   def create(conn, %{"topic" => topic}) do
    # changeset = Topic.changeset(%Topic{}, topic)

    changeset = conn.assigns.user
      |> build_assoc(:topics)   # looks into users model ands sees has_many
      |> Blog.changeset(topic)

    case Repo.insert(changeset) do
      {:ok, _topic} -> 
        conn
        |> put_flash(:info, "Blog Post Created")
        |> redirect(to: topic_path(conn, :index))
      {:error, changeset} -> 
        render conn, "new.html", changeset: changeset
    end
  end
end

defmodule LitHub.PostController do
  use LitHub.Web, :controller

  alias LitHub.Post

   plug LitHub.Plugs.RequireAuth when action in [
    :new,
    :create,
    :edit,
    :update,
    :delete
  ]

  # plug :check_topic_owner when action in [
  #   :update,
  #   :edit,
  #   :delete
  # ]

  def index(conn, _params) do
    posts = Repo.all(Post)
    render(conn, "index.html", posts: posts)
  end

  def jsonIndex(conn, _params) do
    posts = Repo.all(Post)

    json conn, posts
  end

  def new(conn, _params) do
    changeset = Post.changeset(%Post{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"post" => post_params}) do
    changeset = Post.changeset(%Post{}, post_params)

    case Repo.insert(changeset) do
      {:ok, _post} ->
        conn
        |> put_flash(:info, "Post created successfully.")
        |> redirect(to: post_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    post = Repo.get!(Post, id)
    render(conn, "show.html", post: post)
  end

  def edit(conn, %{"id" => id}) do
    post = Repo.get!(Post, id)
    changeset = Post.changeset(post)
    render(conn, "edit.html", post: post, changeset: changeset)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Repo.get!(Post, id)
    changeset = Post.changeset(post, post_params)

    case Repo.update(changeset) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post updated successfully.")
        |> redirect(to: post_path(conn, :show, post))
      {:error, changeset} ->
        render(conn, "edit.html", post: post, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Repo.get!(Post, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(post)

    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: post_path(conn, :index))
  end

  # def check_topic_owner(conn, _params) do # whenever you try to delete update or destrpy the id is passed in url
  #   %{params: %{"id" => post_id}} = conn

  #   # @TODO - ADD ADMIN FUNCTIONALITY HERE
  #   if Repo.get(Topic, post_id).user_id == conn.assigns.user.id do
  #     conn
  #   else
  #     conn
  #     |> put_flash(:error, "You don't have access!")
  #     |> redirect(to: post_path(conn, :index))
  #     |> halt()
  #   end
end

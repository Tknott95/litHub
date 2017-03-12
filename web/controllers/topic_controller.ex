defmodule LitHub.TopicController do
  use LitHub.Web, :controller

  alias LitHub.Topic

  plug LitHub.Plugs.RequireAuth when action in [
    :new,
    :create,
    :edit,
    :update,
    :delete
  ]

  plug :check_topic_owner when action in [
    :update,
    :edit,
    :delete
  ]

  def index(conn, _params) do
    IO.inspect(conn.assigns)
    topics = Repo.all(Topic)

    render conn, "index.html", topics: topics
  end

  def jsonIndex(conn, _params) do
    topics = from(t in Topic, select: %{id: t.id, title: t.title})
      |> Repo.all

    json conn, topics
  end

  def new(conn, _params) do
    changeset = Topic.changeset(%Topic{}, %{})

    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"topic" => topic}) do
    # changeset = Topic.changeset(%Topic{}, topic)

    changeset = conn.assigns.user
      |> build_assoc(:topics)   # looks into users model ands sees has_many
      |> Topic.changeset(topic)

    case Repo.insert(changeset) do
      {:ok, _topic} -> 
        conn
        |> put_flash(:info, "Language Created")
        |> redirect(to: topic_path(conn, :index))
      {:error, changeset} -> 
        render conn, "new.html", changeset: changeset
    end
  end

  def edit(conn, %{"id" => topic_id}) do
    topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(topic)

    render conn, "edit.html", changeset: changeset, topic: topic
  end

  def update(conn, %{"id" => topic_id, "topic" => topic}) do
    old_topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(old_topic, topic)

    case Repo.update(changeset) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Language Updated")
        |> redirect(to: topic_path(conn, :index))
      {:error, changeset} ->
        render conn, "edit.html", changeset: changeset, topic: old_topic
    end
  end

  def delete(conn, %{"id" => topic_id}) do
    Repo.get!(Topic, topic_id) |> Repo.delete!

    conn
    |> put_flash(:info, "Language Deleted")
    |> redirect(to: topic_path(conn, :index))
  end

  def check_topic_owner(conn, _params) do # whenever you try to delete update or destrpy the id is passed in url
    %{params: %{"id" => topic_id}} = conn

    # @TODO - ADD ADMIN FUNCTIONALITY HERE
    if Repo.get(Topic, topic_id).user_id == conn.assigns.user.id do
      conn
    else
      conn
      |> put_flash(:error, "You don't have access!")
      |> redirect(to: topic_path(conn, :index))
      |> halt()
    end
  end
end

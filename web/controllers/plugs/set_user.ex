defmodule LitHub.Plugs.SetUser do
  import Plug.Conn
  import Phoenix.Controller

  alias LitHub.Repo
  alias LitHub.User

  def init(_params) do
    # required to define even if not used
  end
  
  def call(conn, _params) do
    user_id = get_session(conn, :user_id)

    cond do
      user = user_id && Repo.get(User, user_id) ->
        assign(conn, :user, user)
      true ->
        assign(conn, :user, nil)
    end
  end
end

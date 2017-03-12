defmodule LitHub.Plugs.RequireAuth do

  import Plug.Conn
  import Phoenix.Controller

  alias LitHub.Router.Helpers
  
  def init(_params) do
    # required to define even if not used
  end

  def call(conn, _params) do
    if conn.assigns[:user] do
      conn
    else
      conn
      |> put_flash(:error, "You must have admin access!")
      |> redirect(to: Helpers.page_path(conn, :index))
      |> halt()
    end
  end
end

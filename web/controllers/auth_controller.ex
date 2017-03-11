defmodule LitHub.AuthController do
  use LitHub.Web, :controller
  plug Ueberauth

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, params) do
    IO.inspect(auth);
  end
end

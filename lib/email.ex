defmodule LitHub.Email do
  use Bamboo.Phoenix, view: LitHub.EmailView

  def welcome_text_email(email_address) do
    new_email()
    |> to(email_address)
    |> from("us@example.com")
    |> subject("Welcome!")
    |> text_body("Welcome to litHub!")
    |> put_text_layout({LitHub.LayoutView, "email.text"})
    |> render("welcome.text")
  end

  def welcome_html_email(email_address) do
    email_address
    |> welcome_text_email()
    |> html_body("<strong>Welcome<strong> to litHubp!")
    |> put_html_layout({LitHub.LayoutView, "email.html"})
    |> render("welcome.html", email_address: email_address)
  end
end

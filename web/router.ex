defmodule LitHub.Router do
  use LitHub.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug LitHub.Plugs.SetUser # module plug - others are function plugs
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LitHub do
    pipe_through :browser # Use the default browser stack

   get "/", PageController, :index # Controller for basic pages (Landing, About, Etc) - Remember Admin API app

   # get "/topics/new", TopicController, :new
   # post "/topics", TopicController, :create
   # get "/topics/:id/edit", TopicController, :edit
   # put "/topics/:id", TopicController, :update

   get "/blog_posts/new", BlogController, :new
   post "/blog_posts", BlogController, :create
   get "/blog_posts", BlogController, :index

   resources "/topics", TopicController
  #  resources "/blog", BlogController
  end

  scope "/auth", LitHub do
    pipe_through :browser

    get "/signout", AuthController, :signout # Conventions should be delete session but..... (this is basic way less painfull K.I.S.S. way)
    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
  end

  # Other scopes may use custom stacks.
  scope "/api", LitHub do
    pipe_through :api

    get "/languages", TopicController, :jsonIndex
  end
end

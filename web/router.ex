defmodule Poster.Router do
  use Poster.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Poster do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/categories", CategoriesController
    post "/categories/:id/mute", CategoriesController, :mute
    post "/categories/:id/revert", CategoriesController, :revert
    resources "/adtype", AdtypeController
    post "/adtype/:id/mute", AdtypeController, :mute
    post "/adtype/:id/revert", AdtypeController, :revert
    resources "/posts", PostsController
    post "/posts/:id/mute", PostsController, :mute
    post "/posts/:id/revert", PostsController, :revert
  end

  # Other scopes may use custom stacks.
  # scope "/api", Poster do
  #   pipe_through :api
  # end
end

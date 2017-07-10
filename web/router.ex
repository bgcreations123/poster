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
    resources "/posts", PostsController
    resources "/categories", CategoriesController
    post "/categories/:id/mute", CategoriesController, :mute
    post "/categories/:id/revert", CategoriesController, :revert
  end

  # Other scopes may use custom stacks.
  # scope "/api", Poster do
  #   pipe_through :api
  # end
end

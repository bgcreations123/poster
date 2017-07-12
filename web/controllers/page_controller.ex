defmodule Poster.PageController do
  use Poster.Web, :controller

  alias Poster.Locations
  alias Poster.Categories

  def index(conn, _params) do
#    locations = Repo.all Locations
#    categories = Repo.all Categories

    render conn, "index.html"
  end
end

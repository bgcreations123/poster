defmodule Poster.SearchController do
  @moduledoc false
  use Poster.Web, :controller

  alias Poster.Posts

  def index(conn, %{"search" => %{"query" => query}}) do
    results = Repo.all Posts
    render conn, "index.html", results: results
  end

end
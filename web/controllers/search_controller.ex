defmodule Poster.SearchController do
  @moduledoc false
  use Poster.Web, :controller

  alias Poster.Posts

  def index(conn, %{"search" => %{"query" => query}}) do
    results = from(p in Posts, where: ilike(p.title, ^"%#{query}%") or ilike(p.content, ^"%#{query}%"))
              |> Repo.all

    render conn, "index.html", results: results
  end

end
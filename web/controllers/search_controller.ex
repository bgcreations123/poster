defmodule Poster.SearchController do
  @moduledoc false
  use Poster.Web, :controller

  alias Poster.Posts

  def index(conn, %{"search" => %{"query" => query}}) do
#   like_term = "%#{search["query"]}%"
#    searchQuery = from p in Post,
#    where: (like(p.name, like_term) or like(s.body, like_term))

    results = from(p in Posts, where: p.title == ^query)
              |> Repo.all

    render conn, "index.html", results: results
  end

end
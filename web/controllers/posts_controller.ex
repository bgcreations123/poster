defmodule Poster.PostsController do
  use Poster.Web, :controller
  use Number

  alias Poster.Posts
  alias Poster.Categories
  alias Poster.QueryFilter

  plug :load_categories when action in [:new, :create, :edit, :update]

  def index(conn, params) do
    page = Posts
           |> QueryFilter.filter(params, [:categories_id])

    page = from(p in page,
           join: c in assoc(p, :categories),
           where: c.status == true,
           preload: [categories: c])
           |> Repo.paginate(params)

    categories = from(c in Categories, where: [parent_id: "null", status: true])
                 |> Repo.all()

    render conn, "index.html", posts: page.entries, page: page, categories: categories
  end

  def new(conn, _params) do
    changeset = Posts.changeset(%Posts{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"posts" => post_params}) do
    changeset = Posts.changeset(%Posts{}, post_params)

    case Repo.insert(changeset) do
      {:ok, _post} ->
        conn
        |> put_flash(:info, "Post created successfully.")
        |> redirect(to: posts_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

    def show(conn, %{"id" => id}) do
      post = Posts.get_and_preload_category(id)
      render(conn, "show.html", post: post)
    end

    def edit(conn, %{"id" => id}) do
      post = Repo.get!(Posts, id)
      changeset = Posts.changeset(post)
      render(conn, "edit.html", post: post, changeset: changeset)
    end

    def update(conn, %{"id" => id, "posts" => post_params}) do
      post = Repo.get!(Posts, id)
      changeset = Posts.changeset(post, post_params)

      case Repo.update(changeset) do
        {:ok, post} ->
          conn
          |> put_flash(:info, "Post updated successfully.")
          |> redirect(to: posts_path(conn, :show, post))
        {:error, changeset} ->
          render(conn, "edit.html", post: post, changeset: changeset)
      end
    end

    def delete(conn, %{"id" => id}) do
      post = Repo.get!(Posts, id)

      # Here we use delete! (with a bang) because we expect
      # it to always work (and if it does not, it will raise an error).
      Repo.delete!(post)

      conn
      |> put_flash(:info, "Post deleted permanently successfully.")
      |> redirect(to: posts_path(conn, :index))
    end

    def revert(conn, %{"id" => id}) do
      from(p in Posts, where: p.id == ^id)
      |> Repo.update_all(set: [status: true])

      conn
      |> put_flash(:info, "Post reverted successfully.")
      |> redirect(to: posts_path(conn, :index))
    end

    def mute(conn, %{"id" => id}) do
      from(p in Posts, where: p.id == ^id)
      |> Repo.update_all(set: [status: false])

      conn
      |> put_flash(:error, "Post deleted successfully.")
      |> redirect(to: posts_path(conn, :index))
    end

    defp load_categories(conn, _) do
      query =
        Categories
        |> Categories.alphabetical
        |> Categories.names_and_ids

      categories = Repo.all query
      assign(conn, :categories, categories)
    end
end

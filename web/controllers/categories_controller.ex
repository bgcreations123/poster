defmodule Poster.CategoriesController do
  use Poster.Web, :controller

  alias Poster.Categories
  alias Poster.AdType
  alias Poster.QueryFilter

  plug :load_adtypes when action in [:new, :create, :edit, :update]
  plug :load_categories when action in [:new, :create, :edit, :update]

  def index(conn, params) do
    page = Categories
           |> QueryFilter.filter(params, [:adtype_id])
           |> Repo.paginate(params)

    adtypes = Repo.all AdType

    render conn, "index.html", adtypes: adtypes, categories: page.entries, page: page
  end

  def new(conn, _params) do
    changeset = Categories.changeset(%Categories{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"categories" => category_params}) do
    changeset = Categories.changeset(%Categories{}, category_params)

    case Repo.insert(changeset) do
      {:ok, _category} ->
        conn
        |> put_flash(:info, "Category created successfully.")
        |> redirect(to: categories_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    category = Categories.get_and_preload_adtype(id)

    render(conn, "show.html", category: category)
  end

  def edit(conn, %{"id" => id}) do
    category = Repo.get!(Categories, id)
    changeset = Categories.changeset(category)
    render(conn, "edit.html", category: category, changeset: changeset)
  end

  def update(conn, %{"id" => id, "categories" => category_params}) do
    category = Repo.get!(Categories, id)
    changeset = Categories.changeset(category, category_params)

    case Repo.update(changeset) do
      {:ok, category} ->
        conn
        |> put_flash(:info, "Category updated successfully.")
        |> redirect(to: categories_path(conn, :show, category))
      {:error, changeset} ->
        render(conn, "edit.html", category: category, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    category = Repo.get!(Categories, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise an error).
    Repo.delete!(category)

    conn
    |> put_flash(:error, "Category Permanently deleted successfully.")
    |> redirect(to: categories_path(conn, :index))
  end

  def revert(conn, %{"id" => id}) do
    from(c in Categories, where: c.id == ^id)
    |> Repo.update_all(set: [status: true])

    conn
    |> put_flash(:info, "Category reverted successfully.")
    |> redirect(to: categories_path(conn, :index))
  end

  def mute(conn, %{"id" => id}) do
    from(c in Categories, where: c.id == ^id)
    |> Repo.update_all(set: [status: false])

    conn
    |> put_flash(:error, "Category deleted successfully.")
    |> redirect(to: categories_path(conn, :index))
  end

  defp load_adtypes(conn, _) do
    query =
      AdType
      |> AdType.alphabetical
      |> AdType.names_and_ids

    adtypes = Repo.all query
    assign(conn, :adtypes, adtypes)
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

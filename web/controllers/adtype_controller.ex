defmodule Poster.AdtypeController do
  @moduledoc false

  use Poster.Web, :controller

  alias Poster.AdType

  def index(conn, _params) do
    adtype = AdType
             |> Repo.all

    render conn, "index.html", adtype: adtype
  end

  def new(conn, _params) do
    changeset = AdType.changeset(%AdType{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"ad_type" => adtype_params}) do
    changeset = AdType.changeset(%AdType{}, adtype_params)

    case Repo.insert(changeset) do
      {:ok, _adtype} ->
        conn
        |> put_flash(:info, "Adtype created successfully.")
        |> redirect(to: adtype_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    adtype = Repo.get!(AdType, id)
    render(conn, "show.html", adtype: adtype)
  end

  def edit(conn, %{"id" => id}) do
    adtype = Repo.get!(AdType, id)
    changeset = AdType.changeset(adtype)
    render(conn, "edit.html", adtype: adtype, changeset: changeset)
  end

  def update(conn, %{"id" => id, "adtype" => adtype_params}) do
    adtype = Repo.get!(AdType, id)
    changeset = AdType.changeset(adtype, adtype_params)

    case Repo.update(changeset) do
      {:ok, adtype} ->
        conn
        |> put_flash(:info, "Adtype updated successfully.")
        |> redirect(to: adtype_path(conn, :show, adtype))
      {:error, changeset} ->
        render(conn, "edit.html", adtype: adtype, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    adtype = Repo.get!(AdType, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise an error).
    Repo.delete!(adtype)

    conn
    |> put_flash(:error, "Adtype Permanently deleted successfully.")
    |> redirect(to: adtype_path(conn, :index))
  end

  def revert(conn, %{"id" => id}) do
    from(t in AdType, where: t.id == ^id)
    |> Repo.update_all(set: [status: true])

    conn
    |> put_flash(:info, "Ad Type Activated Successfully.")
    |> redirect(to: adtype_path(conn, :index))
  end

  def mute(conn, %{"id" => id}) do
    from(t in AdType, where: t.id == ^id)
    |> Repo.update_all(set: [status: false])

    conn
    |> put_flash(:error, "Ad Type deleted successfully.")
    |> redirect(to: adtype_path(conn, :index))
  end

end
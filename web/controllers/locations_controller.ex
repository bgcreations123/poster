defmodule Poster.LocationsController do
  @moduledoc false

  use Poster.Web, :controller

  alias Poster.Locations

  def index(conn, _params) do
    locations = Repo.all Locations

    render conn, "index.html", locations: locations
  end

  def new(conn, _params) do
    changeset = Locations.changeset(%Locations{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"locations" => locations_params}) do
    changeset = Locations.changeset(%Locations{}, locations_params)

    case Repo.insert(changeset) do
      {:ok, _locations} ->
        conn
        |> put_flash(:info, "Location created successfully.")
        |> redirect(to: locations_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    location = Repo.get!(Locations, id)
    render(conn, "show.html", location: location)
  end

  def edit(conn, %{"id" => id}) do
    location = Repo.get!(Locations, id)
    changeset = Locations.changeset(location)
    render(conn, "edit.html", location: location, changeset: changeset)
  end

  def update(conn, %{"id" => id, "locations" => locations_params}) do
    location = Repo.get!(Locations, id)
    changeset = Locations.changeset(location, locations_params)

    case Repo.update(changeset) do
      {:ok, location} ->
        conn
        |> put_flash(:info, "Location updated successfully.")
        |> redirect(to: locations_path(conn, :show, location))
      {:error, changeset} ->
        render(conn, "edit.html", location: location, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    location = Repo.get!(Locations, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise an error).
    Repo.delete!(location)

    conn
    |> put_flash(:error, "Location Permanently deleted successfully.")
    |> redirect(to: locations_path(conn, :index))
  end

  def revert(conn, %{"id" => id}) do
    from(l in Locations, where: l.id == ^id)
    |> Repo.update_all(set: [status: true])

    conn
    |> put_flash(:info, "Location Activated Successfully.")
    |> redirect(to: locations_path(conn, :index))
  end

  def mute(conn, %{"id" => id}) do
    from(l in Locations, where: l.id == ^id)
    |> Repo.update_all(set: [status: false])

    conn
    |> put_flash(:error, "Location deleted successfully.")
    |> redirect(to: locations_path(conn, :index))
  end
end
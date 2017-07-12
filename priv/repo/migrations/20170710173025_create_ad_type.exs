defmodule Poster.Repo.Migrations.CreateAdType do
  use Ecto.Migration

  def change do
    create table(:types) do
      add :status, :boolean, default: true
      add :name, :string
      add :description, :text

      timestamps()
    end

  end
end

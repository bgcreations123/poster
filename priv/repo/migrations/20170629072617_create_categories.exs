defmodule Poster.Repo.Migrations.CreateCategories do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :parent_id, :string
      add :category_id, :int
      add :name, :string
      add :description, :text

      timestamps()
    end

  end
end

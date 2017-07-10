defmodule Poster.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :categories_id, :int
      add :status, :boolean, default: true
      add :title, :string
      add :content, :text
      add :price, :float

      timestamps()
    end

  end
end

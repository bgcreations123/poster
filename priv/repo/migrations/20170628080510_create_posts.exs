defmodule Poster.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :adtype_id, :int
      add :categories_id, :int
      add :user_id, :int
      add :location_id, :int
      add :status, :boolean, default: false
      add :title, :string
      add :content, :text
      add :price, :float

      timestamps()
    end

  end
end

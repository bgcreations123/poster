defmodule Poster.Repo.Migrations.CreateLocation do
  use Ecto.Migration

  def change do
    create table(:locations) do
      add :status, :boolean, default: true
      add :name, :string

      timestamps()
    end

  end
end

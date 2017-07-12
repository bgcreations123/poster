defmodule Poster.Repo.Migrations.CreateSubscriber do
  use Ecto.Migration

  def change do
    create table(:subscribers) do
      add :user_id, :int
      add :location_id, :int

      timestamps()
    end

  end
end

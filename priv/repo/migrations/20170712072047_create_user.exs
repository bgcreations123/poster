defmodule Poster.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :first_name, :string
      add :last_name, :string
      add :phone_number, :string
      add :email_address, :string

      timestamps()
    end

  end
end

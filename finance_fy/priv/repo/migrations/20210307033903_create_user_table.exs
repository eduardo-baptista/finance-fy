defmodule FinanceFy.Repo.Migrations.CreateUserTable do
@moduledoc """
  Migration to create user table
"""
  use Ecto.Migration

  def change do
    create table :users do
      add :name, :string, size: 20
      add :email, :string, size: 100
      add :password_hash, :string

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end

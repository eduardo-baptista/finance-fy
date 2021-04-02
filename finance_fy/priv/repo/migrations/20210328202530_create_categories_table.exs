defmodule FinanceFy.Repo.Migrations.CreateCategoriesTable do
@moduledoc """
  Migration to create categories table
"""
  use Ecto.Migration

  def change do
    create table :categories do
      add :user_id, references(:users, type: :binary_id, on_delete: :delete_all), null: false
      add :name, :string, size: 100, null: false
      add :is_positive, :boolean, null: false

      timestamps()
    end

    create unique_index(:categories, [:user_id])
    create unique_index(:categories, [:user_id, :is_positive])
  end
end

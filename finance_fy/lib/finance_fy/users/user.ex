defmodule FinanceFy.Users.User do
@moduledoc """
  Ecto schema for users table
"""
  use Ecto.Schema
  import Ecto.Changeset

  alias Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [:name, :email, :password, :password_confirmation]

  schema "users" do
    field :email, :string
    field :name, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:name, max: 20)
    |> validate_length(:email, max: 100)
    |> validate_length(:password, min: 6)
    |> validate_format(:email, ~r/@/)
    |> validate_confirmation(:password)
    |> unique_constraint([:email])
    |> put_password_hash()
  end

  defp put_password_hash(
    %Changeset{valid?: true, changes: %{password: password}} = changeset
  ) do
    change(changeset, Bcrypt.add_hash(password))
  end

  defp put_password_hash(changeset), do: changeset
end

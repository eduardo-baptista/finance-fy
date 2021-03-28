defmodule FinanceFy.Users.Create do
@moduledoc """
  Create new user and save it
"""
  alias FinanceFy.Repo
  alias FinanceFy.Users.User

  def call (params) do
    params
    |> User.changeset()
    |> Repo.insert()
  end
end

defmodule FinanceFy.User.Create do
@moduledoc """
  Create new user and save it
"""
  alias FinanceFy.Repo
  alias FinanceFy.User

  def call (params) do
    params
    |> User.changeset()
    |> Repo.insert()
  end
end

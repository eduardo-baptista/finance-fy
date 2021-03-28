defmodule FinanceFy.Users.SignIn do
@moduledoc """
  Sign in user and generates authentication token
"""
  import FinanceFy.Guardian

  alias FinanceFy.Repo
  alias FinanceFy.Users.User

  def call(email, password) do
    with %User{} = user <- Repo.get_by(User, email: email),
         true <- Bcrypt.verify_pass(password, user.password_hash),
         {:ok, token, _claims} <- encode_and_sign(user)
    do
      {:ok, user, token}
    else
      _ -> {:error, :authentication_fail}
    end
  end
end

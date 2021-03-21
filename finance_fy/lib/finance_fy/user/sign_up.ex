defmodule FinanceFy.User.SignUp do
@moduledoc """
  Create a new user and sign in
  """
  import FinanceFy.Guardian

  alias FinanceFy.User.Create

  def call (params) do
    with {:ok, user} <- Create.call(params),
         {:ok, token, _claims} <- encode_and_sign(user)
    do
      {:ok, user, token}
    else
      {:error, reason} -> {:error, reason}
    end
  end
end

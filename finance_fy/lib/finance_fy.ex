defmodule FinanceFy do
  @moduledoc """
  FinanceFy keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  alias FinanceFy.Users.{SignIn, SignUp}

  defdelegate sign_in_user(email, password), to: SignIn, as: :call
  defdelegate sign_up_user(params), to: SignUp, as: :call
end

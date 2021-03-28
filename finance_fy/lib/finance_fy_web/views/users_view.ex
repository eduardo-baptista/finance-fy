defmodule FinanceFyWeb.UsersView do
  alias FinanceFy.Users.User

  def render("create.json", %{user: %User{} = user, token: token}) do
    %{
      email: user.email,
      id: user.id,
      name: user.name,
      token: token,
    }
  end
end

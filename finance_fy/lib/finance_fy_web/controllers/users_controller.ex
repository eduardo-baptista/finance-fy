defmodule FinanceFyWeb.UsersController do
  use FinanceFyWeb, :controller

  action_fallback FinanceFyWeb.FallbackController

  def create(conn, params) do
    with {:ok, user, token} <- FinanceFy.sign_up_user(params) do
      conn
      |> put_status(:created)
      |> render("create.json", %{user: user, token: token})
    end
  end
end

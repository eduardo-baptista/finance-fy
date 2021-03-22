defmodule FinanceFyWeb.SessionsController do
  use FinanceFyWeb, :controller

  action_fallback FinanceFyWeb.FallbackController

  def create(conn, params) do
    with {:ok, %{email: email, password: password}} <- validate_request(
        %{email: :string, password: :string},
        params
      ),
      {:ok, user, token} <- FinanceFy.sign_in_user(email, password)
    do
      conn
      |> put_status(:ok)
      |> render("create.json", %{user: user, token: token})
    end
  end
end

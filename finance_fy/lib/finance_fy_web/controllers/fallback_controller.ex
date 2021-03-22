defmodule FinanceFyWeb.FallbackController do
  use FinanceFyWeb, :controller

  alias Ecto.Changeset

  def call(conn, {:error, %Changeset{} = result}) do
    conn
    |> put_status(:bad_request)
    |> put_view(FinanceFyWeb.ErrorView)
    |> render("400.json", result: result)
  end

  def call(conn, {:error, :authentication_fail}) do
    conn
    |> put_status(:bad_request)
    |> put_view(FinanceFyWeb.ErrorView)
    |> render("400.json", message: "Authentication fail")
  end
end

defmodule FinanceFyWeb.FallbackController do
  use FinanceFyWeb, :controller

  alias Ecto.Changeset

  def call(conn, {:error, %Changeset{} = result}) do
    conn
    |> put_status(:bad_request)
    |> put_view(FinanceFyWeb.ErrorView)
    |> render("400.json", result: result)
  end
end

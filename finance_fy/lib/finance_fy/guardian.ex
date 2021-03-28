defmodule FinanceFy.Guardian do
@moduledoc """
  Handle JWT authentication and generation
"""
  use Guardian, otp_app: :finance_fy

  alias FinanceFy.Users.User
  alias FinanceFy.Repo

  def subject_for_token(%User{id: id}, _claims), do: {:ok, id}
  def subject_for_token(_, _), do: {:error, :invalid_user}

  def resource_from_claims(%{"sub" => user_id}) do
    resource = Repo.get!(User, user_id)
    {:ok, resource}
  end
  def resource_from_claims(_claims) do
    {:error, :invalid_user}
  end
end

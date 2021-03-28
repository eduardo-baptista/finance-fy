defmodule FinanceFy.Users.SignInTest do
  @moduledoc """
    Sign in user and generates authentication token
  """
    use FinanceFy.DataCase, async: true

    alias FinanceFy.Guardian
    alias FinanceFy.Users.SignIn
    alias FinanceFy.Users.User

    describe "call/2" do
      setup do
        params = %{
          email: "shinzou@sasageyo.com",
          name: "Tatakae",
          password: "abc@123",
          password_confirmation: "abc@123"
        }

        {:ok, user} = Repo.insert(User.changeset(params))

        %{created_user: user}
      end

      test "When provide a valid email and password it should return a valid token", %{created_user: user} do
        # Act
        {:ok, _user, token} = SignIn.call(user.email, user.password)
        {:ok, claims} = Guardian.decode_and_verify(token)

        # Assert
        assert claims["sub"] === user.id
      end

      test "When provide a wrong email it should return authentication error", %{created_user: user} do
        # Arrange
        wrong_email = "wrong_email"

        # Act
        {:error, reason} = SignIn.call(wrong_email, user.password)

        # Assert
        assert reason === :authentication_fail
      end

      test "When provide a wrong password it should return authentication error", %{created_user: user} do
        # Arrange
        wrong_password = "wrong_password"

        # Act
        {:error, reason} = SignIn.call(user.email, wrong_password)

        # Assert
        assert reason === :authentication_fail
      end
    end
  end

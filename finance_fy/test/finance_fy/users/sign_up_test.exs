defmodule FinanceFy.Users.SignUpTest do
  @moduledoc """
    Create a new user and sign in
    """
    use FinanceFy.DataCase, async: true

    alias FinanceFy.Guardian
    alias FinanceFy.Repo
    alias FinanceFy.Users.User
    alias FinanceFy.Users.SignUp

    describe "call/1" do
      test "When all params are valid it should return a valid token" do
        # Arrange
        params = %{
          email: "shinzou@sasageyo.com",
          name: "Tatakae",
          password: "abc@123",
          password_confirmation: "abc@123"
        }

        # Act
        {:ok, %User{} = user, token} = SignUp.call(params)
        {:ok, claims} = Guardian.decode_and_verify(token)

        # assert
        assert claims["sub"] === user.id
      end

      test "When has wrong params it should return validations errors" do
        # Arrange
        params = %{
          email: "shinzou sasageyo",
          name: "Tatakae Tatakae Tatakae Tatakae",
          password: "abc",
          password_confirmation: "abc@123"
        }

        # Act
        {:error, reason} = SignUp.call(params)

        # assert
        expected_value = %{
          email: ["has invalid format"],
          name: ["should be at most 20 character(s)"],
          password: ["should be at least 6 character(s)"],
          password_confirmation: ["does not match confirmation"]
        }
        assert errors_on(reason) === expected_value
      end
    end
  end

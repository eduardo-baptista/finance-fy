defmodule FinanceFyWeb.UsersControllerTest do
@moduledoc """
  Users controller
"""
  alias FinanceFy.Guardian
  use FinanceFyWeb.ConnCase, async: true

  describe "create/2" do
    test "When all params are valid it should return created user", %{conn: conn} do
      # Arrange
      params = %{
        email: "shinzou@sasageyo.com",
        name: "Tatakae",
        password: "abc@123",
        password_confirmation: "abc@123"
      }

      # Act
      response =
      conn
      |> post(Routes.users_path(conn, :create, params))
      |> json_response(:created)

      # Assert
      assert %{
        "id" => _id,
        "email" => "shinzou@sasageyo.com",
        "name" => "Tatakae",
      } = response
    end

    test "When all params are valid it should return valid token", %{conn: conn} do
      # Arrange
      params = %{
        email: "shinzou@sasageyo.com",
        name: "Tatakae",
        password: "abc@123",
        password_confirmation: "abc@123"
      }

      # Act
      %{"token" => token, "id" => id} =
      conn
      |> post(Routes.users_path(conn, :create, params))
      |> json_response(:created)

      {:ok, claims} = Guardian.decode_and_verify(token)

      # Assert
      assert claims["sub"] === id
    end

    test "When has wrong params it should return validations errors", %{conn: conn} do
      # Arrange
      params = %{
        email: "shinzou sasageyo",
        name: "Tatakae Tatakae Tatakae Tatakae",
        password: "abc",
        password_confirmation: "abc@123"
      }

      # Act
      response =
      conn
      |> post(Routes.users_path(conn, :create, params))
      |> json_response(:bad_request)

      # Assert
      expected_value = %{
        "errors" => %{
          "email" => ["has invalid format"],
          "name" => ["should be at most 20 character(s)"],
          "password" => ["should be at least 6 character(s)"],
          "password_confirmation" => ["does not match confirmation"]
        }
      }
      assert expected_value === response
    end
  end
end

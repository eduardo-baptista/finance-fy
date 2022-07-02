defmodule FinanceFyWeb.SessionsControllerTest do
  @moduledoc """
    Users controller
  """
  alias FinanceFy.Guardian
  alias FinanceFy.Repo
  alias FinanceFy.Users.User

  use FinanceFyWeb.ConnCase, async: true

  describe "create/2" do
    setup do
      params = %{
        email: "shinzou@sasageyo.com",
        name: "Tatakae",
        password: "abc@123",
        password_confirmation: "abc@123"
      }

      {:ok, user} = Repo.insert(User.changeset(params))

      %{user: user}
    end

    test "When all params are valid it should return user info", %{
      conn: conn,
      user: user
    } do
      # Arrange
      params = %{
        "email" => user.email,
        "password" => user.password
      }

      # Act
      response =
        conn
        |> post(Routes.sessions_path(conn, :create, params))
        |> json_response(:ok)

      # Assert
      assert %{
               "id" => _id,
               "email" => "shinzou@sasageyo.com",
               "name" => "Tatakae"
             } = response
    end

    test "When all params are valid it should return valid token", %{
      conn: conn,
      user: user
    } do
      # Arrange
      params = %{
        "email" => user.email,
        "password" => user.password
      }

      # Act
      %{"token" => token, "id" => id} =
        conn
        |> post(Routes.sessions_path(conn, :create, params))
        |> json_response(:ok)

      {:ok, claims} = Guardian.decode_and_verify(token)

      # Assert
      assert claims["sub"] === id
    end

    test "When send empty body it should return validations errors", %{
      conn: conn
    } do
      # Arrange
      params = %{}

      # Act
      response =
        conn
        |> post(Routes.sessions_path(conn, :create, params))
        |> json_response(:bad_request)

      # Assert
      expected_value = %{
        "errors" => %{
          "email" => ["can't be blank"],
          "password" => ["can't be blank"]
        }
      }

      assert response === expected_value
    end

    test "When send wrong email it should return authentication error", %{
      conn: conn,
      user: user
    } do
      # Arrange
      params = %{
        "email" => "wrong@email.com",
        "password" => user.password
      }

      # Act
      response =
        conn
        |> post(Routes.sessions_path(conn, :create, params))
        |> json_response(:bad_request)

      # Assert
      expected_value = %{"message" => "Authentication fail"}
      assert response === expected_value
    end

    test "When send wrong password it should return authentication error", %{
      conn: conn,
      user: user
    } do
      # Arrange
      params = %{
        "email" => user.email,
        "password" => "wrong"
      }

      # Act
      response =
        conn
        |> post(Routes.sessions_path(conn, :create, params))
        |> json_response(:bad_request)

      # Assert
      expected_value = %{"message" => "Authentication fail"}
      assert response === expected_value
    end
  end
end

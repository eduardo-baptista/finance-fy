defmodule FinanceFy.User.CreateTest do
  @moduledoc """
    Test create user
  """
    use FinanceFy.DataCase, async: true

    alias FinanceFy.Repo
    alias FinanceFy.User
    alias FinanceFy.User.Create

    describe "call/1" do
      test "When all params are valid it should return an created user" do
        # Arrange
        params = %{
          email: "shinzou@sasageyo.com",
          name: "Tatakae",
          password: "abc@123",
          password_confirmation: "abc@123"
        }

        # Act
        {:ok, %User{id: user_id}} = Create.call(params)

        user = Repo.get(User, user_id)

        # Assert
        assert %User{
          email: "shinzou@sasageyo.com",
          id: ^user_id,
          name: "Tatakae"
        } = user
      end

      test "When creates new user it should encrypt password correctly" do
        # Arrange
        params = %{
          email: "shinzou@sasageyo.com",
          name: "Tatakae",
          password: "abc@123",
          password_confirmation: "abc@123"
        }

        # Act
        {:ok, %User{password_hash: password_hash}} = Create.call(params)

        # Assert
        assert Bcrypt.verify_pass(params.password, password_hash)
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
        {:error, changeset} = Create.call(params)

        # Assert
        expected_value = %{
          email: ["has invalid format"],
          name: ["should be at most 20 character(s)"],
          password: ["should be at least 6 character(s)"],
          password_confirmation: ["does not match confirmation"]
        }
        assert expected_value === errors_on(changeset)
      end

      test "When already has an user with same e-mail it should return error" do
        # Arrange
        params = %{
          email: "shinzou@sasageyo.com",
          name: "Tatakae",
          password: "abc@123",
          password_confirmation: "abc@123"
        }

        #Act
        Create.call(params)
        {:error, changeset} = Create.call(params)

        # Assert
        expected_value = %{email: ["has already been taken"]}
        assert expected_value === errors_on(changeset)
      end
    end
  end

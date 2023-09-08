defmodule Todo.UsersTest do
  use Todo.DataCase
  use ExUnit.Case, async: true

  alias Pow.Ecto.Schema
  alias Todo.Users
  alias Todo.Users.User


  describe "users" do

    import Todo.UsersFixtures

    @invalid_attrs %{password: nil, username: nil, password_confirmation: nil}


    test "creates user with unique username" do
      some_user = user_fixture()

      changeset = User.changeset(%User{}, %{username: "some username", password: "password", password_confirmation: "some password"})
      case Repo.insert(changeset) do
        {:error, %Ecto.Changeset{}} ->
          assert true

        {:ok, _user} ->
          assert false, "Expected an error but got OK"
      end
    end



    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Users.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Users.get_user!(user.id) == user
    end


    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{password: "some password", password_confirmation: "some password", username: "some username"}

      assert {:ok, %User{} = user} = Users.create_user(valid_attrs)
      assert user.username == "some username"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{username: "some updated username", current_password: "some password"}

      assert {:ok, %User{} = user} = Users.update_user(user, update_attrs)
      # assert user.password == "some updated password"
      assert user.username == "some updated username"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Users.update_user(user, @invalid_attrs)
      assert user == Users.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Users.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Users.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Users.change_user(user)
    end
  end
end

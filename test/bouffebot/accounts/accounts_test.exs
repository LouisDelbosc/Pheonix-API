defmodule Bouffebot.AccountsTest do
  use Bouffebot.DataCase

  alias Bouffebot.Accounts

  describe "users" do
    alias Bouffebot.Accounts.User

    @valid_attrs %{
      email: "email@test.com",
      password: "some password",
      password_confirmation: "some password"
    }
    @update_attrs %{
      email: "updatedemail@test.com",
      password: "some updated password",
      password_confirmation: "some updated password"
    }
    @invalid_attrs %{email: nil, password: nil, password_confirmation: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      exported = Accounts.list_users() |> Enum.map(fn x -> {x.email, x.id} end)

      assert exported == [{user.email, user.id}]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id).email == user.email
      assert Accounts.get_user!(user.id).id == user.id
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == "email@test.com"
      assert Bcrypt.verify_pass("some password", user.password_hash)
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.email == "updatedemail@test.com"
      assert Bcrypt.verify_pass("some updated password", user.password_hash)
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user.email == Accounts.get_user!(user.id).email
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    # test "change_user/1 returns a user changeset" do
    #   user = user_fixture() |> IO.inspect
    #   assert %Ecto.Changeset{} = Accounts.change_user(user)
    # end
  end
end

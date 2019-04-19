defmodule BouffebotWeb.UserControllerTest do
  use BouffebotWeb.ConnCase

  alias Bouffebot.Accounts
  alias Bouffebot.Accounts.User

  @create_attrs %{
    email: "email@test.com",
    password: "some password",
    password_confirmation: "some password"
  }
  @invalid_attrs %{email: nil, password: nil, password_confirmatin: nil}

  def fixture(:user) do
    {:ok, user} = Accounts.create_user(@create_attrs)
    user
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  # describe "index" do
  #   test "lists all users", %{conn: conn} do
  #     conn = get(conn, Routes.user_path(conn, :show))
  #     assert json_response(conn, 200)["data"] == []
  #   end
  # end

  describe "create user" do
    #   test "renders user when data is valid", %{conn: conn} do
    #     conn = post(conn, Routes.user_path(conn, :create), user: @create_attrs)
    #     assert %{"id" => id} = json_response(conn, 200)["data"]

    #     conn = get(conn, Routes.user_path(conn, :show))

    #     assert %{
    #              "id" => id,
    #              "email" => "email@test.com",
    #              "password_hash" => _x
    #            } = json_response(conn, 200)["data"]
    #   end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  defp create_user(_) do
    user = fixture(:user)
    {:ok, user: user}
  end
end

defmodule Bouffebot.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bcrypt

  schema "users" do
    field :email, :string
    field :password_hash, :string

    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :password, :password_confirmation])
    |> validate_required([:email, :password, :password_confirmation])
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 8)
    |> validate_confirmation(:password)
    |> unique_constraint(:email)
    |> put_password_hash()
  end

  defp put_password_hash(%Ecto.Changeset{valid?: true, changes: changes} = changeset) do
    change(changeset, password_hash: Bcrypt.hash_pwd_salt(changes.password))
  end

  defp put_password_hash(%Ecto.Changeset{valid?: false} = changeset), do: changeset
end

defmodule Bouffebot.Guardian do
  use Guardian, otp_app: :bouffebot
  alias Bouffebot.Accounts

  def subject_for_token(user, _claims), do: {:ok, to_string(user.id)}
  def subject_for_token(_, _), do: {:error, :reason_for_error}

  def resource_from_claims(claims) do
    id = claims["sub"]
    resource = Accounts.get_user!(id)
    {:ok, resource}
  end

  def resouce_from_claims(_), do: {:error, :reason_for_error}
end

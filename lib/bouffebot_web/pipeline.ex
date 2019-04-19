defmodule Bouffebot.Guardian.AuthPipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :bouffebot,
    module: Bouffebot.Guardian,
    error_handler: Bouffebot.AuthErrorHandler

  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end

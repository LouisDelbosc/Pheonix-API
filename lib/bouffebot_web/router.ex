defmodule BouffebotWeb.Router do
  use BouffebotWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api/v1", BouffebotWeb do
    pipe_through :api

    resources "/users", UserController
  end
end

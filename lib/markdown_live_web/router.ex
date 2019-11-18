defmodule MarkdownLiveWeb.Router do
  use MarkdownLiveWeb, :router
  import Phoenix.LiveView.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MarkdownLiveWeb do
    pipe_through :browser

    get "/", PostController, :new
    resources "/posts", PostController, only: [:new, :show]
  end

  # Other scopes may use custom stacks.
  # scope "/api", MarkdownLiveWeb do
  #   pipe_through :api
  # end
end

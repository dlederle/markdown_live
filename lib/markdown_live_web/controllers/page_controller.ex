defmodule MarkdownLiveWeb.PageController do
  import Phoenix.LiveView.Controller

  use MarkdownLiveWeb, :controller

  def editor(conn, _params) do
    conn
    |> live_render(MarkdownLiveWeb.Editor, session: %{})
  end
end

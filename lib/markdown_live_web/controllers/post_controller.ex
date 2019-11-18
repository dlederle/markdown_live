defmodule MarkdownLiveWeb.PostController do
  import Phoenix.LiveView.Controller
  alias MarkdownLive.Post
  alias MarkdownLive.PostSupervisor

  use MarkdownLiveWeb, :controller

  def new(conn, _params) do
    # creates a new post_id
    id = "abcd"

    # Create a post process
    case PostSupervisor.start_post_server(id) do
      {:ok, _post_pid} -> 
        conn
        |> redirect to: Routes.post_path(conn, :show, id)
      {:error, {:already_started, _post_pid}} ->
        conn
        |> redirect to: Routes.post_path(conn, :show, id)
      _ ->
        conn
        |> send_resp(500, "error lol")
    end
  end


  def show(conn, %{"id" => id}) do
    # TODO: start post server lol
    uuid = :rand.uniform(10000) |> to_string
    conn
    |> live_render(MarkdownLiveWeb.Editor, session: %{id: id, session_uuid: uuid})
  end
end


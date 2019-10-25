defmodule MarkdownLiveWeb.Editor do
  use Phoenix.LiveView
  use Phoenix.HTML
  alias MarkdownLive.Post

  def render(assigns) do
    ~L"""
    <div>
      <h1>Markdown Live Editor</h1>
      <form phx-submit="upload" enctype="multipart/form-data">
        <input name="filefield" type="file"></input>
        <button phx-disable-with="loading...">Upload</button>
      </form>
      <textarea name="body" phx-keyup="update"><%= @raw %></textarea>
      <div>
        <h1>Rendered Output</h1>
        <%= raw(@rendered) %>
      </div>
    </div>
    """
  end

  def mount(_sesson, socket) do
    {:ok, assign(socket, %{raw: "", rendered: ""})}
  end

  def handle_event("update", %{"value" => raw} = body, socket) do
    IO.puts(socket)
    IO.puts("update: #{socket}")
    {:ok, rendered_html} = Post.render(raw)
    {:noreply, assign(socket, rendered: rendered_html)}
  end

  def handle_event("upload", %{"filefield" => raw} = body, socket) do
    IO.puts("upload: #{socket}")
    {:ok, rendered_html} = Post.render(raw)
    {:noreply, assign(socket, rendered: rendered_html)}
  end
end

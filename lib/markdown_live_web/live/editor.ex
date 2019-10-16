defmodule MarkdownLiveWeb.Editor do
  use Phoenix.LiveView
  use Phoenix.HTML
  alias MarkdownLive.Post

  def render(assigns) do
    ~L"""
    <div>
      <h1>Markdown Live Editor</h1>
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
    {:ok, rendered_html} = Post.render(raw)
    {:noreply, assign(socket, rendered: rendered_html)}
  end
end

defmodule MarkdownLiveWeb.Editor do
  use Phoenix.LiveView
  use Phoenix.HTML
  alias MarkdownLive.Post

  def render(assigns) do
    ~L"""
    <h1>Markdown Live Editor</h1>
    <form phx-change="update">
      <textarea><%= @raw %></textarea>
    </form>
    <div>
      <h1>Rendered Output</h1>
      <%= raw(@rendered) %>
    """
  end

  def mount(_sesson, socket) do
    {:ok, assign(socket, %{raw: "", rendered: ""})}
  end

  def handle_event("update", state, %{assigns: %{raw: raw}} = socket) do
    {:ok, rendered_html} = Post.render(raw)
    {:noreply, assign(socket, rendered: rendered_html)}
  end
end

defmodule MarkdownLiveWeb.Editor do
  use Phoenix.LiveView
  use Phoenix.HTML

  def render(assigns) do
    ~L"""
    <h1>Markdown Live Editor</h1>
    <form phx-change="update" phx-change="update phx-change="update"">
      <textarea><%= @raw %></textarea>
    </form>
    <div>
      <h1>Rendered Output</h1>
      <%= raw(@rendered) %>
    """
  end

  def mount(_sesson, socket) do
    {:ok, assign(socket, %{raw: "Hi there", rendered: "<h1>Helooooo</h1>"})}
  end

  def handle_event("update", state, socket) do
    rendered_html = "Rendering!"
    {:noreply, assign(socket, rendered: rendered_html)}
  end
end

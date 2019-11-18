defmodule MarkdownLiveWeb.Editor do
  use Phoenix.LiveView
  use Phoenix.HTML
  alias MarkdownLive.PostServer

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

  def mount(%{id: id}, socket) do
    # Connect to Post by id
    post = PostServer.summary(id)

    {:ok, assign(socket, post)}
  end

  def handle_event("update", %{"value" => raw} = body, socket) do
    id = "whatnow"
    %{rendered: rendered_html} = PostServer.update(id, %{raw: raw})
    {:noreply, assign(socket, rendered: rendered_html)}
  end
end

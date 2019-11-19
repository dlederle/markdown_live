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

  def mount(%{id: post_id}, socket) do
    :ok = Phoenix.PubSub.subscribe(MarkdownLive.PubSub, post_id)
    {:ok, assign_post(socket, post_id)}
  end

  def handle_event("update", %{"value" => raw}, socket) do
    post_id = socket.assigns.post_id
    PostServer.update(post_id, %{raw: raw})
    :ok = Phoenix.PubSub.broadcast(MarkdownLive.PubSub, post_id, :update)
    {:noreply, assign_post(socket)}
  end
  
  def handle_info(:update, socket) do
    {:noreply, assign_post(socket)}
  end

  defp assign_post(socket, post_id) do
    socket
    |> assign(post_id: post_id)
    |> assign_post()
  end

  defp assign_post(%{assigns: %{post_id: post_id}} = socket) do
    post = PostServer.summary(post_id)
    assign(socket, rendered: post.rendered, raw: post.raw)
  end
end

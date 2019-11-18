defmodule MarkdownLiveWeb.Editor do
  use Phoenix.LiveView
  use Phoenix.HTML
  alias MarkdownLive.PostServer

  def render(assigns) do
    ~L"""
    <div id="editor" data-session-uuid="<%= assigns.session_uuid %>">
      
      <h1>Markdown Live Editor</h1>
      <textarea name="body" phx-keyup="update"><%= @raw %></textarea>
      <div>
        <h1>Rendered Output</h1>
        <%= raw(@rendered) %>
      </div>
    </div>
    """
  end

  def mount(%{id: id, session_uuid: session_uuid}, socket) do
    # register self as listener
    # PostServer.subscribe(id, self(), socket)
    # Connect to Post by id
    post = PostServer.summary(id)
    
    IO.puts("Mounting #{session_uuid}")

    {:ok, assign(socket, raw: post.raw, rendered: post.rendered, session_uuid: session_uuid)}
  end

  def handle_event("update", %{"value" => raw} = body, socket = %{assigns: %{session_uuid: session_uuid}}) do
    IO.puts("Updating from #{session_uuid}")

    id = "abcd"

    send(self(), {:broadcast_post_update, "update"})
    %{rendered: rendered_html} = PostServer.update(id, %{raw: raw})
    {:noreply, assign(socket, rendered: rendered_html)}
  end

  def handle_info({:broadcast_post_update, msg}, socket = %{assigns: %{session_uuid: session_uuid}}) do
    IO.puts("Broadcast update from #{session_uuid}")

    [{_pid, channel_pid}] = Registry.lookup(Registry.SessionRegistry, session_uuid)
    send(channel_pid, msg)
    {:noreply, socket}
  end
end

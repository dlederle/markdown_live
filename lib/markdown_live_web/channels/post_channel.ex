defmodule MarkdownLiveWeb.PostChannel do
  use Phoenix.Channel

  def join("post:" <> _post_id, _post_body, socket) do
    IO.puts("Registering #{socket.assigns.session_uuid}")
    Registry.register(Registry.SessionRegistry, socket.assigns.session_uuid, self())
    {:ok, socket}
  end

  def handle_info("update", socket = %{topic: "post:" <> post_id}) do
    IO.puts("Updating the socket: #{socket.assigns.session_uuid}")

    # push(socket, post, %{})
    #{:noreply, assign(socket, rendered: rendered_html)}
    # post = PostServer.summary(post_id)
    #
    {:noreply, socket}

  end
end

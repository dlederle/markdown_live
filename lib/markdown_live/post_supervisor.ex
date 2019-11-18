defmodule MarkdownLive.PostSupervisor do
  use DynamicSupervisor
  alias MarkdownLive.PostSupervisor

  def start_link(_arg) do
    DynamicSupervisor.start_link(PostSupervisor, :ok, name: PostSupervisor)
  end

  @impl true
  def init(_arg) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def start_post_server(id) do
    child_spec = %{
      id: MarkdownLive.PostServer,
      start: {MarkdownLive.PostServer, :start_link, [id]},
      # don't restart game server processes that exit normally
      restart: :transient
    }
    DynamicSupervisor.start_child(PostSupervisor, child_spec)
  end
end

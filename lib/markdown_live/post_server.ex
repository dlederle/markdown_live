defmodule MarkdownLive.PostServer do
  use GenServer

  def start_link(id) do
    # GenServer.start_link(__MODULE__, {id}, name: {:via, PostRegistry, id})
    GenServer.start_link(__MODULE__, {id}, name: :post)
  end

  def summary(id) do
    #GenServer.call({:via, PostRegistry, id}, :summary)
    GenServer.call(:post, :summary)
  end

  def update(_id, %{raw: raw}) do
    #GenServer.call({:via, PostRegistry, id}, {:update, raw})
    GenServer.call(:post, {:update, raw})
  end

  @impl true
  def handle_call({:update, raw}, _from, post_state) do
    {:ok, rendered_html} = MarkdownLive.Post.render(raw)
    next_state = %{raw: raw, rendered: rendered_html}

    {:reply, next_state, next_state}
  end

  @impl true
  def handle_call(:summary, from, post_state) do
    {:reply, post_state, post_state}
  end

  @impl true
  def init(_id) do
    {:ok, %{raw: "", rendered: ""}}
  end
end

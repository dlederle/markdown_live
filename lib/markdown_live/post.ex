defmodule MarkdownLive.Post do
  # defstruct %Post{body: body}

  # render/1
  def render(body) do
    {:ok, "<h1>From within Post</h1>"}
  end
end

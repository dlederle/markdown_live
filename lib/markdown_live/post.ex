defmodule MarkdownLive.Post do
  # defstruct %Post{body: body}

  # render/1
  def render(body) do
    {:ok, Earmark.as_html!(body)}
  end
end

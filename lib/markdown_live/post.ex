defmodule MarkdownLive.Post do
  # defstruct %Post{raw: raw, rendered: rendered}

  # render/1
  def render(body) do
    {:ok, Earmark.as_html!(body)}
  end
end

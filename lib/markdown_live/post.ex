defmodule MarkdownLive.Post do
  # defstruct %Post{body: body}

  # render/1
  def render(body) do
    rendered =
      body
      |> Panpipe.to_html()

    {:ok, rendered}
  end

  # def render(file) do
  #   Panpipe.pandoc(input: file)
  # end
end

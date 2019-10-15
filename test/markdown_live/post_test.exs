defmodule MarkdownLive.PostTest do
  use MarkdownLive.LiveCase
  alias MarkdownLive.Post

  test "render_post" do
    input = "# Hello World"
    assert Post.render(input) == {:ok, "<h1>Hello World</h1>"}
  end
end


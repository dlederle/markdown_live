defmodule MarkdownLive.PostTest do
  use ExUnit.Case, async: true
  alias MarkdownLive.Post

  test "render/1" do
    input = "# Hello World"
    assert Post.render(input) == {:ok, "<h1>Hello World</h1>\n"}
  end
end


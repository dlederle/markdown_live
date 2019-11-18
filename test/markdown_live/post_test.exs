defmodule MarkdownLive.PostTest do
  use ExUnit.Case, async: true
  alias MarkdownLive.Post

  @shortcode = "abcd"

  setup do
    [post: Post.create(@shortcode)]
  end

  test "render/1" do
    input = "# Hello World"
    assert Post.render(input) == {:ok, "<h1>Hello World</h1>"}
  end

  test "", %{post: post} do
    {:ok, rendered} = Post.update(post, "## Hello World")
    assert rendered == {"<h2>Hello World</h2>"}
  end
end


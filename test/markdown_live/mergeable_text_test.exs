defmodule MarkdownLive.MergeableTextTest do
  use ExUnit.Case, async: true
  alias MarkdownLive.MergeableText

  describe "get_operations/2" do
    test "returns a list of operations to transform string1 into string2" do
      s1 = "Hello"
      s2 = "hello"

      assert MergeableText.get_operations(s1, s2) == [%{d: "H"}, %{i: "h"}, 4]
    end

    test "returns a delete operation if a substring should be removed" do
      s1 = "What is up?"
      s2 = "is up?"

      assert MergeableText.get_operations(s1, s2) == [%{d: "What "}, 6]
    end

    test "returns an insert operation if a substring should be inserted" do
      s1 = "Michael Jordan"
      s2 = "Michael Jordan is the GOAT"

      assert MergeableText.get_operations(s1, s2) == [14, %{i: " is the GOAT"}]
    end

    test "returns a number of characters to skip if the strings are the same" do
      s1 = "First"
      s2 = "First"

      assert MergeableText.get_operations(s1, s2) == [5]
    end
  end
end

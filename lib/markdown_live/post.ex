defmodule MarkdownLive.Post do
  import MarkdownLive.MergeableText

  defstruct raw: ""

  def render(%__MODULE__{raw: raw}) do
    render(raw)
  end

  def render(body) do
    {:ok, Earmark.as_html!(body)}
  end

  def update(%__MODULE__{raw: raw}, new_text) do
    ops = get_operations(raw, new_text)

    # TODO: Handle errors lol
    {:ok, updated} = apply_operations(raw, ops)

    %__MODULE__{raw: updated}
  end
end

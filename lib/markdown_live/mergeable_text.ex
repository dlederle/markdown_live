defmodule MarkdownLive.MergeableText do
  def get_operations(original, updated) do
    original
    |> String.myers_difference(updated)
    |> Enum.map(&convert_operation_keys/1)
  end

  def apply_operations(original, operations) do
    OT.Text.Application.apply(original, operations)
  end

  # String.myers_diference returns different keys than the OT library expects
  defp convert_operation_keys({:del, v}), do: %{d: v}
  defp convert_operation_keys({:ins, v}), do: %{i: v}
  defp convert_operation_keys({:eq, v}), do: String.length(v)
end

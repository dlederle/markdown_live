# Stolen from https://elixirschool.com/blog/live-view-with-channels/
defmodule MarkdownLiveWeb.LiveSocket do
  @moduledoc """
  The LiveView socket for Phoenix Endpoints.
  """
  use Phoenix.Socket

  defstruct id: nil,
    endpoint: nil,
    parent_pid: nil,
    assigns: %{},
    changed: %{},
    fingerprints: {nil, %{}},
    private: %{},
    stopped: nil,
    connected?: false

  channel "lv:*", Phoenix.LiveView.Channel
  channel "post:*", MarkdownLiveWeb.PostChannel

  @doc """
  Connects the Phoenix.Socket for a LiveView client.
  """
  @impl Phoenix.Socket
  def connect(params, socket, _connect_info) do
    {:ok, assign(socket, :session_uuid, params["session_uuid"])}
  end

  @doc """
  Identifies the Phoenix.Socket for a LiveView client.
  """
  @impl Phoenix.Socket
  def id(_socket), do: nil
end


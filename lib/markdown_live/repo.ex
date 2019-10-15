defmodule MarkdownLive.Repo do
  use Ecto.Repo,
    otp_app: :markdown_live,
    adapter: Ecto.Adapters.Postgres
end

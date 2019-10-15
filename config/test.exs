use Mix.Config

# Configure your database
config :markdown_live, MarkdownLive.Repo,
  username: "postgres",
  password: "postgres",
  database: "markdown_live_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :markdown_live, MarkdownLiveWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

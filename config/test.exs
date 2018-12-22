use Mix.Config

config :logger,
  level: :warn

# if secret exists use that, otherwise
# use env variables
if File.exists?("config/test.secret.exs") do
  import_config "test.secret.exs"
else
  config :news_api,
    api_key: System.get_env("NA_PRIVATEKEY")
end

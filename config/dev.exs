use Mix.Config

# if secret exists use that, otherwise
# use env variables
if File.exists?("config/dev.secret.exs") do
  import_config "dev.secret.exs"
else
  config :news_api,
    api_key: System.get_env("NA_PRIVATEKEY")
end

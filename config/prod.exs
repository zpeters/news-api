use Mix.Config

# if secret exists use that, otherwise
# use env variables
if File.exists?("config/prod.secret.exs") do
  import_config "prod.secret.exs"
else
  config :news_api,
    api_key: System.get_env("NA_PRIVATEKEY")
end

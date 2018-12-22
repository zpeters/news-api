use Mix.Config

config :news_api,
  country: "US"

import_config "#{Mix.env()}.exs"

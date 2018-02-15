defmodule NewsApi.Mixfile do
  use Mix.Project

  def project do
    [
      app: :news_api,
      version: "0.1.0",
      elixir: "~> 1.5",
      description: "Wrapper for News API",
      start_permanent: Mix.env == :prod,
      deps: deps(),
      package: package()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 1.0"}
    ]
  end
  
  defp package do
    [
      maintainers: ["radvc"],
      licenses: ["MIT"],
      links: %{"Github" => "https://github.com/radvc/news-api"}
    ]
  end
end

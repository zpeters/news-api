# NewsApi

**TODO: Add description**

## Installation

The package can be installed
by adding `news_api` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:news_api, "~> 0.1.0"}
  ]
end
```
## Configuration
Get your API key at https://newsapi.org/.

In your ```dev.secret.exs```, ```prod.secret.exs``` , ```test.secret.exs```:

```
config :news_api, api_key: "YOUR_API_KEY"
```

or

set the `NA_PRIVATEKEY` environment variable

## Usage

Get headlines by passing 2-letter ISO 3166-1 code of the country.

```elixir
NewsApi.get("ph")
```

Get headlines by category:

```elixir
NewsApi.get_by_category("ph", "business")
```


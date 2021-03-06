defmodule NewsApi do
  @moduledoc """
  Module for news api operations
  """

  alias NewsApi.{Api}

  @doc """
  Paramters:
  - `country` - 2 letter ISO 3166-1 code, cannot be used with `sources`
  - `category` - one of _business_, _entertainment_, _general_, _health_, _science_, _sports_, _technology_.  Cannot be used with `sources`
  - `sources` - comma-separated list of sources (see `/sources`) cannot be used with `country` or `category`
  - `q` - keywords or phrase to search for
  - `pageSize` - number of results to return.  Default 20, 100 maximum
  - `page` - page to retrieve
  """
  def top_headlines(parameters) do
    Api.get_top_headlines(parameters)
  end

  @doc """
  Paramters:
  - `country` - 2 letter ISO 3166-1 code, cannot be used with `sources`
  - `category` - one of _business_, _entertainment_, _general_, _health_, _science_, _sports_, _technology_.  Cannot be used with `sources`
  - `language` - Possible options: ar de en es fr he it nl no pt ru se ud zh
  """
  def get_sources(parameters) do
    Api.get_sources(parameters)
  end

  @doc """
  See https://newsapi.org/docs/endpoints/everything for more extensive details
  Parameters:
  - q - query keywords or phrase
  - sources - comma separated news sources
  - domains - comma separated domains to restrict to
  - excludeDomains - comma separated domains to exclude
  - from - A date and optional time for the oldest article allowed. This should be in ISO 8601 format (e.g. 2018-12-23 or 2018-12-23T00:16:52) Default: the oldest according to your plan.
  - to - A date and optional time for the newest article allowed. This should be in ISO 8601 format (e.g. 2018-12-23 or 2018-12-23T00:16:52) Default: the newest according to your plan.
  - language - The 2-letter ISO-639-1 code of the language you want to get headlines for. Possible options: ar de en es fr he it nl no pt ru se ud zh . Default: all languages returned.
  - sortBy - The order to sort the articles in. Possible options: relevancy, popularity, publishedAt.
   - relevancy = articles more closely related to q come first.
   - popularity = articles from popular sources and publishers come first.
   - publishedAt = newest articles come first.
  - pageSize - The number of results to return per page. 20 is the default, 100 is the maximum.
  - page - Use this to page through the results.
  """
  def everything(parameters) do
    Api.get_everything(parameters)
  end
end

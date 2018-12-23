defmodule NewsApi.Api do
  @moduledoc """
  API communication
  """

  require Logger

  @base_url "https://newsapi.org/v2/"

  @doc """
  Paramters:
  - `country` - 2 letter ISO 3166-1 code, cannot be used with `sources`
  - `category` - one of _business_, _entertainment_, _general_, _health_, _science_, _sports_, _technology_.  Cannot be used with `sources`
  - `sources` - comma-separated list of sources (see `/sources`) cannot be used with `country` or `category`
  - `q` - keywords or phrase to search for
  - `pageSize` - number of results to return.  Default 20, 100 maximum
  - `page` - page to retrieve
  """
  def get_top_headlines(parameters) do
    cond do
      Keyword.keys(parameters) == [] ->
        {:error, :invalid_parameters, "Need one of: sources, q, language, country, category"}

      Keyword.has_key?(parameters, :country) and Keyword.has_key?(parameters, :sources) ->
        {:error, :invalid_parameters, "Cannot specify 'country' and 'sources'"}

      Keyword.has_key?(parameters, :category) and Keyword.has_key?(parameters, :sources) ->
        {:error, :invalid_parameters, "Cannot specify 'category' and 'sources'"}

      true ->
        get("/top-headlines", parameters)
    end
  end

  @doc """
  Paramters:
  - `country` - 2 letter ISO 3166-1 code, cannot be used with `sources`
  - `category` - one of _business_, _entertainment_, _general_, _health_, _science_, _sports_, _technology_.  Cannot be used with `sources`
  - `language` - Possible options: ar de en es fr he it nl no pt ru se ud zh
  """
  def get_sources(parameters \\ []) do
    get("/sources", parameters)
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
  def get_everything(parameters) do
    get("/everything", parameters)
  end

  @spec get(String.t(), list()) :: map()
  defp get(path, parameters) do
    url = "#{@base_url}#{path}"

    result =
      url
      |> call_api(headers(), parameters)
      |> match_result()

    {:ok, result}
  rescue
    err ->
      {:error, :get_failed, err}
  end

  @spec headers :: list()
  defp headers do
    api_key = Application.get_env(:news_api, :api_key)
    [Authorization: "Bearer #{api_key}", Accept: "Application/json"]
  end

  @spec call_api(String.t(), list, list) :: String.t()
  defp call_api(url, headers, parameters) do
    Logger.debug(fn -> "#{inspect(url)}" end)
    Logger.debug(fn -> "#{inspect(parameters)}" end)
    HTTPoison.get!(url, headers, params: parameters)
  end

  @spec match_result(struct()) :: map()
  defp match_result(result) do
    case result do
      %{status_code: 200, body: body} ->
        decode_result(body)

      %{status_code: 401} ->
        %{message: "API key is missing"}
    end
  end

  @spec decode_result(String.t()) :: map()
  defp decode_result(result) do
    Jason.decode!(result)
  end
end

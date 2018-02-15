defmodule NewsApi do
  @moduledoc """
  Module for news api operations
  """

  @base_url "https://newsapi.org/v2/"
  
  @spec get(String.t()) :: map()
  def get(country) do
    result = call_api("#{@base_url}top-headlines?country=#{country}", headers())
    match_result(result)
  end
  
  @spec get(String.t(), String.t()) :: map()
  def get(country, category) do
    result = call_api("#{@base_url}top-headlines?country=#{country}&category=#{category}", headers())
    match_result(result)
  end
  
  @spec headers :: list()
  defp headers do
    api_key = Application.get_env(:news_api, :api_key)
    ["Authorization": "Bearer #{api_key}", "Accept": "Application/json"]
  end

  @spec call_api(String.t(), list) :: String.t()
  defp call_api(url, headers) do
    HTTPoison.get!(url, headers) 
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
    Poison.decode!(result)
  end
end

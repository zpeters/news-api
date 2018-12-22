defmodule NewsApiApiTest do
  use ExUnit.Case
  doctest NewsApi

  alias NewsApi.Api

  describe "get_sources/0 get_sources/1" do
    test "no parameters" do
      {:ok, resp} = Api.get_sources()
      sources = resp["sources"]

      assert resp["status"] == "ok"
      assert length(sources) > 0
    end

    test "valid category" do
      {:ok, resp} = Api.get_sources(category: "technology")
      sources = resp["sources"]

      assert resp["status"] == "ok"
      assert length(sources) > 0
    end

    test "valid language" do
      {:ok, resp} = Api.get_sources(language: "en")
      sources = resp["sources"]

      assert resp["status"] == "ok"
      assert length(sources) > 0
    end

    test "valid country" do
      {:ok, resp} = Api.get_sources(country: "us")
      sources = resp["sources"]

      assert resp["status"] == "ok"
      assert length(sources) > 0
    end

    test "invalid category" do
      {:ok, resp} = Api.get_sources(category: "FAKE")
      sources = resp["sources"]

      assert resp["status"] == "ok"
      assert length(sources) == 0
    end

    test "invalid language" do
      {:ok, resp} = Api.get_sources(language: "FAKE")
      sources = resp["sources"]

      assert resp["status"] == "ok"
      assert length(sources) == 0
    end

    test "invalid country" do
      {:ok, resp} = Api.get_sources(country: "FAKE")
      sources = resp["sources"]

      assert resp["status"] == "ok"
      assert length(sources) == 0
    end

    test "invalid parameters" do
      {:ok, resp} = Api.get_sources(nothing: "FAKE")
      sources = resp["sources"]

      assert resp["status"] == "ok"
      assert length(sources) > 0
    end
  end

  describe "get_top_headlines/1" do
    test "fail on invalid parameters country and sources" do
      params = [country: "US", sources: "Source 1, Source 2"]
      {:error, :invalid_parameters, _msg} = Api.get_top_headlines(params)
    end

    test "fail on invalid parameters category and sources" do
      params = [category: "technology", sources: "Source 1, Source 2"]
      {:error, :invalid_parameters, _msg} = Api.get_top_headlines(params)
    end

    test "pass on country only" do
      params = [country: "US"]
      {:ok, results} = Api.get_top_headlines(params)
      assert results != %{message: "API key is missing"}
      articles = Map.get(results, "articles")
      assert length(articles) > 0
    end

    test "pass on category only" do
      params = [category: "technology"]
      {:ok, results} = Api.get_top_headlines(params)
      assert results != %{message: "API key is missing"}
      articles = Map.get(results, "articles")
      assert length(articles) > 0
    end

    test "fail on bad category only" do
      params = [category: "myfakecategory"]
      {:ok, results} = Api.get_top_headlines(params)
      assert results != %{message: "API key is missing"}
      assert Map.get(results, "totalResults") == 0
    end

    test "pass on q only" do
      params = [q: "news"]
      {:ok, results} = Api.get_top_headlines(params)
      assert results != %{message: "API key is missing"}
      articles = Map.get(results, "articles")
      assert length(articles) > 0
    end
  end
end

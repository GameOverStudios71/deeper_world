defmodule DeeperHub.HubFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DeeperHub.Hub` context.
  """

  @doc """
  Generate a language.
  """
  def language_fixture(attrs \\ %{}) do
    {:ok, language} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> DeeperHub.Hub.create_language()

    language
  end

  @doc """
  Generate a category.
  """
  def category_fixture(attrs \\ %{}) do
    {:ok, category} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> DeeperHub.Hub.create_category()

    category
  end

  @doc """
  Generate a status.
  """
  def status_fixture(attrs \\ %{}) do
    {:ok, status} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> DeeperHub.Hub.create_status()

    status
  end

  @doc """
  Generate a engine.
  """
  def engine_fixture(attrs \\ %{}) do
    {:ok, engine} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> DeeperHub.Hub.create_engine()

    engine
  end

  @doc """
  Generate a network.
  """
  def network_fixture(attrs \\ %{}) do
    {:ok, network} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> DeeperHub.Hub.create_network()

    network
  end

  @doc """
  Generate a content_type.
  """
  def content_type_fixture(attrs \\ %{}) do
    {:ok, content_type} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> DeeperHub.Hub.create_content_type()

    content_type
  end

  @doc """
  Generate a server.
  """
  def server_fixture(attrs \\ %{}) do
    {:ok, server} =
      attrs
      |> Enum.into(%{
        ai_generated: true,
        ai_permission: true,
        allow_anonymous: true,
        city: "some city",
        country: "some country",
        description_full: "some description_full",
        description_hero: "some description_hero",
        encryption_level: "some encryption_level",
        feature_colors: "some feature_colors",
        latitude: 120.5,
        longitude: 120.5,
        max_connections: 42,
        min_age: 42,
        picture_box: "some picture_box",
        picture_featured: "some picture_featured",
        picture_icon: "some picture_icon",
        picture_mini: "some picture_mini",
        ping_ms: 42,
        platform_version: "some platform_version",
        region: "some region",
        reputation: 42,
        screenshoots: "some screenshoots",
        server_cpu_info: "some server_cpu_info",
        server_max_users: 42,
        server_name: "some server_name",
        server_rules: "some server_rules",
        url: "some url",
        verified: true,
        visited_users_lst_mounth: 42
      })
      |> DeeperHub.Hub.create_server()

    server
  end
end

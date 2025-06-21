defmodule DeeperHub.HubTest do
  use DeeperHub.DataCase

  alias DeeperHub.Hub

  describe "languages" do
    alias DeeperHub.Hub.Language

    import DeeperHub.HubFixtures

    @invalid_attrs %{name: nil}

    test "list_languages/0 returns all languages" do
      language = language_fixture()
      assert Hub.list_languages() == [language]
    end

    test "get_language!/1 returns the language with given id" do
      language = language_fixture()
      assert Hub.get_language!(language.id) == language
    end

    test "create_language/1 with valid data creates a language" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Language{} = language} = Hub.create_language(valid_attrs)
      assert language.name == "some name"
    end

    test "create_language/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Hub.create_language(@invalid_attrs)
    end

    test "update_language/2 with valid data updates the language" do
      language = language_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Language{} = language} = Hub.update_language(language, update_attrs)
      assert language.name == "some updated name"
    end

    test "update_language/2 with invalid data returns error changeset" do
      language = language_fixture()
      assert {:error, %Ecto.Changeset{}} = Hub.update_language(language, @invalid_attrs)
      assert language == Hub.get_language!(language.id)
    end

    test "delete_language/1 deletes the language" do
      language = language_fixture()
      assert {:ok, %Language{}} = Hub.delete_language(language)
      assert_raise Ecto.NoResultsError, fn -> Hub.get_language!(language.id) end
    end

    test "change_language/1 returns a language changeset" do
      language = language_fixture()
      assert %Ecto.Changeset{} = Hub.change_language(language)
    end
  end

  describe "categories" do
    alias DeeperHub.Hub.Category

    import DeeperHub.HubFixtures

    @invalid_attrs %{name: nil}

    test "list_categories/0 returns all categories" do
      category = category_fixture()
      assert Hub.list_categories() == [category]
    end

    test "get_category!/1 returns the category with given id" do
      category = category_fixture()
      assert Hub.get_category!(category.id) == category
    end

    test "create_category/1 with valid data creates a category" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Category{} = category} = Hub.create_category(valid_attrs)
      assert category.name == "some name"
    end

    test "create_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Hub.create_category(@invalid_attrs)
    end

    test "update_category/2 with valid data updates the category" do
      category = category_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Category{} = category} = Hub.update_category(category, update_attrs)
      assert category.name == "some updated name"
    end

    test "update_category/2 with invalid data returns error changeset" do
      category = category_fixture()
      assert {:error, %Ecto.Changeset{}} = Hub.update_category(category, @invalid_attrs)
      assert category == Hub.get_category!(category.id)
    end

    test "delete_category/1 deletes the category" do
      category = category_fixture()
      assert {:ok, %Category{}} = Hub.delete_category(category)
      assert_raise Ecto.NoResultsError, fn -> Hub.get_category!(category.id) end
    end

    test "change_category/1 returns a category changeset" do
      category = category_fixture()
      assert %Ecto.Changeset{} = Hub.change_category(category)
    end
  end

  describe "statuses" do
    alias DeeperHub.Hub.Status

    import DeeperHub.HubFixtures

    @invalid_attrs %{name: nil}

    test "list_statuses/0 returns all statuses" do
      status = status_fixture()
      assert Hub.list_statuses() == [status]
    end

    test "get_status!/1 returns the status with given id" do
      status = status_fixture()
      assert Hub.get_status!(status.id) == status
    end

    test "create_status/1 with valid data creates a status" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Status{} = status} = Hub.create_status(valid_attrs)
      assert status.name == "some name"
    end

    test "create_status/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Hub.create_status(@invalid_attrs)
    end

    test "update_status/2 with valid data updates the status" do
      status = status_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Status{} = status} = Hub.update_status(status, update_attrs)
      assert status.name == "some updated name"
    end

    test "update_status/2 with invalid data returns error changeset" do
      status = status_fixture()
      assert {:error, %Ecto.Changeset{}} = Hub.update_status(status, @invalid_attrs)
      assert status == Hub.get_status!(status.id)
    end

    test "delete_status/1 deletes the status" do
      status = status_fixture()
      assert {:ok, %Status{}} = Hub.delete_status(status)
      assert_raise Ecto.NoResultsError, fn -> Hub.get_status!(status.id) end
    end

    test "change_status/1 returns a status changeset" do
      status = status_fixture()
      assert %Ecto.Changeset{} = Hub.change_status(status)
    end
  end

  describe "engines" do
    alias DeeperHub.Hub.Engine

    import DeeperHub.HubFixtures

    @invalid_attrs %{name: nil}

    test "list_engines/0 returns all engines" do
      engine = engine_fixture()
      assert Hub.list_engines() == [engine]
    end

    test "get_engine!/1 returns the engine with given id" do
      engine = engine_fixture()
      assert Hub.get_engine!(engine.id) == engine
    end

    test "create_engine/1 with valid data creates a engine" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Engine{} = engine} = Hub.create_engine(valid_attrs)
      assert engine.name == "some name"
    end

    test "create_engine/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Hub.create_engine(@invalid_attrs)
    end

    test "update_engine/2 with valid data updates the engine" do
      engine = engine_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Engine{} = engine} = Hub.update_engine(engine, update_attrs)
      assert engine.name == "some updated name"
    end

    test "update_engine/2 with invalid data returns error changeset" do
      engine = engine_fixture()
      assert {:error, %Ecto.Changeset{}} = Hub.update_engine(engine, @invalid_attrs)
      assert engine == Hub.get_engine!(engine.id)
    end

    test "delete_engine/1 deletes the engine" do
      engine = engine_fixture()
      assert {:ok, %Engine{}} = Hub.delete_engine(engine)
      assert_raise Ecto.NoResultsError, fn -> Hub.get_engine!(engine.id) end
    end

    test "change_engine/1 returns a engine changeset" do
      engine = engine_fixture()
      assert %Ecto.Changeset{} = Hub.change_engine(engine)
    end
  end

  describe "networks" do
    alias DeeperHub.Hub.Network

    import DeeperHub.HubFixtures

    @invalid_attrs %{name: nil}

    test "list_networks/0 returns all networks" do
      network = network_fixture()
      assert Hub.list_networks() == [network]
    end

    test "get_network!/1 returns the network with given id" do
      network = network_fixture()
      assert Hub.get_network!(network.id) == network
    end

    test "create_network/1 with valid data creates a network" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Network{} = network} = Hub.create_network(valid_attrs)
      assert network.name == "some name"
    end

    test "create_network/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Hub.create_network(@invalid_attrs)
    end

    test "update_network/2 with valid data updates the network" do
      network = network_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Network{} = network} = Hub.update_network(network, update_attrs)
      assert network.name == "some updated name"
    end

    test "update_network/2 with invalid data returns error changeset" do
      network = network_fixture()
      assert {:error, %Ecto.Changeset{}} = Hub.update_network(network, @invalid_attrs)
      assert network == Hub.get_network!(network.id)
    end

    test "delete_network/1 deletes the network" do
      network = network_fixture()
      assert {:ok, %Network{}} = Hub.delete_network(network)
      assert_raise Ecto.NoResultsError, fn -> Hub.get_network!(network.id) end
    end

    test "change_network/1 returns a network changeset" do
      network = network_fixture()
      assert %Ecto.Changeset{} = Hub.change_network(network)
    end
  end

  describe "content_types" do
    alias DeeperHub.Hub.ContentType

    import DeeperHub.HubFixtures

    @invalid_attrs %{name: nil}

    test "list_content_types/0 returns all content_types" do
      content_type = content_type_fixture()
      assert Hub.list_content_types() == [content_type]
    end

    test "get_content_type!/1 returns the content_type with given id" do
      content_type = content_type_fixture()
      assert Hub.get_content_type!(content_type.id) == content_type
    end

    test "create_content_type/1 with valid data creates a content_type" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %ContentType{} = content_type} = Hub.create_content_type(valid_attrs)
      assert content_type.name == "some name"
    end

    test "create_content_type/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Hub.create_content_type(@invalid_attrs)
    end

    test "update_content_type/2 with valid data updates the content_type" do
      content_type = content_type_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %ContentType{} = content_type} = Hub.update_content_type(content_type, update_attrs)
      assert content_type.name == "some updated name"
    end

    test "update_content_type/2 with invalid data returns error changeset" do
      content_type = content_type_fixture()
      assert {:error, %Ecto.Changeset{}} = Hub.update_content_type(content_type, @invalid_attrs)
      assert content_type == Hub.get_content_type!(content_type.id)
    end

    test "delete_content_type/1 deletes the content_type" do
      content_type = content_type_fixture()
      assert {:ok, %ContentType{}} = Hub.delete_content_type(content_type)
      assert_raise Ecto.NoResultsError, fn -> Hub.get_content_type!(content_type.id) end
    end

    test "change_content_type/1 returns a content_type changeset" do
      content_type = content_type_fixture()
      assert %Ecto.Changeset{} = Hub.change_content_type(content_type)
    end
  end

  describe "servers" do
    alias DeeperHub.Hub.Server

    import DeeperHub.HubFixtures

    @invalid_attrs %{server_name: nil, url: nil, verified: nil, latitude: nil, longitude: nil, country: nil, region: nil, city: nil, description_hero: nil, description_full: nil, ping_ms: nil, visited_users_lst_mounth: nil, reputation: nil, ai_permission: nil, ai_generated: nil, server_rules: nil, server_cpu_info: nil, server_max_users: nil, min_age: nil, picture_box: nil, picture_icon: nil, picture_featured: nil, picture_mini: nil, screenshoots: nil, feature_colors: nil, platform_version: nil, allow_anonymous: nil, max_connections: nil, encryption_level: nil}

    test "list_servers/0 returns all servers" do
      server = server_fixture()
      assert Hub.list_servers() == [server]
    end

    test "get_server!/1 returns the server with given id" do
      server = server_fixture()
      assert Hub.get_server!(server.id) == server
    end

    test "create_server/1 with valid data creates a server" do
      valid_attrs = %{server_name: "some server_name", url: "some url", verified: true, latitude: 120.5, longitude: 120.5, country: "some country", region: "some region", city: "some city", description_hero: "some description_hero", description_full: "some description_full", ping_ms: 42, visited_users_lst_mounth: 42, reputation: 42, ai_permission: true, ai_generated: true, server_rules: "some server_rules", server_cpu_info: "some server_cpu_info", server_max_users: 42, min_age: 42, picture_box: "some picture_box", picture_icon: "some picture_icon", picture_featured: "some picture_featured", picture_mini: "some picture_mini", screenshoots: "some screenshoots", feature_colors: "some feature_colors", platform_version: "some platform_version", allow_anonymous: true, max_connections: 42, encryption_level: "some encryption_level"}

      assert {:ok, %Server{} = server} = Hub.create_server(valid_attrs)
      assert server.server_name == "some server_name"
      assert server.url == "some url"
      assert server.verified == true
      assert server.latitude == 120.5
      assert server.longitude == 120.5
      assert server.country == "some country"
      assert server.region == "some region"
      assert server.city == "some city"
      assert server.description_hero == "some description_hero"
      assert server.description_full == "some description_full"
      assert server.ping_ms == 42
      assert server.visited_users_lst_mounth == 42
      assert server.reputation == 42
      assert server.ai_permission == true
      assert server.ai_generated == true
      assert server.server_rules == "some server_rules"
      assert server.server_cpu_info == "some server_cpu_info"
      assert server.server_max_users == 42
      assert server.min_age == 42
      assert server.picture_box == "some picture_box"
      assert server.picture_icon == "some picture_icon"
      assert server.picture_featured == "some picture_featured"
      assert server.picture_mini == "some picture_mini"
      assert server.screenshoots == "some screenshoots"
      assert server.feature_colors == "some feature_colors"
      assert server.platform_version == "some platform_version"
      assert server.allow_anonymous == true
      assert server.max_connections == 42
      assert server.encryption_level == "some encryption_level"
    end

    test "create_server/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Hub.create_server(@invalid_attrs)
    end

    test "update_server/2 with valid data updates the server" do
      server = server_fixture()
      update_attrs = %{server_name: "some updated server_name", url: "some updated url", verified: false, latitude: 456.7, longitude: 456.7, country: "some updated country", region: "some updated region", city: "some updated city", description_hero: "some updated description_hero", description_full: "some updated description_full", ping_ms: 43, visited_users_lst_mounth: 43, reputation: 43, ai_permission: false, ai_generated: false, server_rules: "some updated server_rules", server_cpu_info: "some updated server_cpu_info", server_max_users: 43, min_age: 43, picture_box: "some updated picture_box", picture_icon: "some updated picture_icon", picture_featured: "some updated picture_featured", picture_mini: "some updated picture_mini", screenshoots: "some updated screenshoots", feature_colors: "some updated feature_colors", platform_version: "some updated platform_version", allow_anonymous: false, max_connections: 43, encryption_level: "some updated encryption_level"}

      assert {:ok, %Server{} = server} = Hub.update_server(server, update_attrs)
      assert server.server_name == "some updated server_name"
      assert server.url == "some updated url"
      assert server.verified == false
      assert server.latitude == 456.7
      assert server.longitude == 456.7
      assert server.country == "some updated country"
      assert server.region == "some updated region"
      assert server.city == "some updated city"
      assert server.description_hero == "some updated description_hero"
      assert server.description_full == "some updated description_full"
      assert server.ping_ms == 43
      assert server.visited_users_lst_mounth == 43
      assert server.reputation == 43
      assert server.ai_permission == false
      assert server.ai_generated == false
      assert server.server_rules == "some updated server_rules"
      assert server.server_cpu_info == "some updated server_cpu_info"
      assert server.server_max_users == 43
      assert server.min_age == 43
      assert server.picture_box == "some updated picture_box"
      assert server.picture_icon == "some updated picture_icon"
      assert server.picture_featured == "some updated picture_featured"
      assert server.picture_mini == "some updated picture_mini"
      assert server.screenshoots == "some updated screenshoots"
      assert server.feature_colors == "some updated feature_colors"
      assert server.platform_version == "some updated platform_version"
      assert server.allow_anonymous == false
      assert server.max_connections == 43
      assert server.encryption_level == "some updated encryption_level"
    end

    test "update_server/2 with invalid data returns error changeset" do
      server = server_fixture()
      assert {:error, %Ecto.Changeset{}} = Hub.update_server(server, @invalid_attrs)
      assert server == Hub.get_server!(server.id)
    end

    test "delete_server/1 deletes the server" do
      server = server_fixture()
      assert {:ok, %Server{}} = Hub.delete_server(server)
      assert_raise Ecto.NoResultsError, fn -> Hub.get_server!(server.id) end
    end

    test "change_server/1 returns a server changeset" do
      server = server_fixture()
      assert %Ecto.Changeset{} = Hub.change_server(server)
    end
  end
end

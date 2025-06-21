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

  describe "achievement_types" do
    alias DeeperHub.Hub.AchievementType

    import DeeperHub.HubFixtures

    @invalid_attrs %{name: nil, description: nil}

    test "list_achievement_types/0 returns all achievement_types" do
      achievement_type = achievement_type_fixture()
      assert Hub.list_achievement_types() == [achievement_type]
    end

    test "get_achievement_type!/1 returns the achievement_type with given id" do
      achievement_type = achievement_type_fixture()
      assert Hub.get_achievement_type!(achievement_type.id) == achievement_type
    end

    test "create_achievement_type/1 with valid data creates a achievement_type" do
      valid_attrs = %{name: "some name", description: "some description"}

      assert {:ok, %AchievementType{} = achievement_type} = Hub.create_achievement_type(valid_attrs)
      assert achievement_type.name == "some name"
      assert achievement_type.description == "some description"
    end

    test "create_achievement_type/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Hub.create_achievement_type(@invalid_attrs)
    end

    test "update_achievement_type/2 with valid data updates the achievement_type" do
      achievement_type = achievement_type_fixture()
      update_attrs = %{name: "some updated name", description: "some updated description"}

      assert {:ok, %AchievementType{} = achievement_type} = Hub.update_achievement_type(achievement_type, update_attrs)
      assert achievement_type.name == "some updated name"
      assert achievement_type.description == "some updated description"
    end

    test "update_achievement_type/2 with invalid data returns error changeset" do
      achievement_type = achievement_type_fixture()
      assert {:error, %Ecto.Changeset{}} = Hub.update_achievement_type(achievement_type, @invalid_attrs)
      assert achievement_type == Hub.get_achievement_type!(achievement_type.id)
    end

    test "delete_achievement_type/1 deletes the achievement_type" do
      achievement_type = achievement_type_fixture()
      assert {:ok, %AchievementType{}} = Hub.delete_achievement_type(achievement_type)
      assert_raise Ecto.NoResultsError, fn -> Hub.get_achievement_type!(achievement_type.id) end
    end

    test "change_achievement_type/1 returns a achievement_type changeset" do
      achievement_type = achievement_type_fixture()
      assert %Ecto.Changeset{} = Hub.change_achievement_type(achievement_type)
    end
  end

  describe "feedback_types" do
    alias DeeperHub.Hub.FeedbackType

    import DeeperHub.HubFixtures

    @invalid_attrs %{name: nil, description: nil}

    test "list_feedback_types/0 returns all feedback_types" do
      feedback_type = feedback_type_fixture()
      assert Hub.list_feedback_types() == [feedback_type]
    end

    test "get_feedback_type!/1 returns the feedback_type with given id" do
      feedback_type = feedback_type_fixture()
      assert Hub.get_feedback_type!(feedback_type.id) == feedback_type
    end

    test "create_feedback_type/1 with valid data creates a feedback_type" do
      valid_attrs = %{name: "some name", description: "some description"}

      assert {:ok, %FeedbackType{} = feedback_type} = Hub.create_feedback_type(valid_attrs)
      assert feedback_type.name == "some name"
      assert feedback_type.description == "some description"
    end

    test "create_feedback_type/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Hub.create_feedback_type(@invalid_attrs)
    end

    test "update_feedback_type/2 with valid data updates the feedback_type" do
      feedback_type = feedback_type_fixture()
      update_attrs = %{name: "some updated name", description: "some updated description"}

      assert {:ok, %FeedbackType{} = feedback_type} = Hub.update_feedback_type(feedback_type, update_attrs)
      assert feedback_type.name == "some updated name"
      assert feedback_type.description == "some updated description"
    end

    test "update_feedback_type/2 with invalid data returns error changeset" do
      feedback_type = feedback_type_fixture()
      assert {:error, %Ecto.Changeset{}} = Hub.update_feedback_type(feedback_type, @invalid_attrs)
      assert feedback_type == Hub.get_feedback_type!(feedback_type.id)
    end

    test "delete_feedback_type/1 deletes the feedback_type" do
      feedback_type = feedback_type_fixture()
      assert {:ok, %FeedbackType{}} = Hub.delete_feedback_type(feedback_type)
      assert_raise Ecto.NoResultsError, fn -> Hub.get_feedback_type!(feedback_type.id) end
    end

    test "change_feedback_type/1 returns a feedback_type changeset" do
      feedback_type = feedback_type_fixture()
      assert %Ecto.Changeset{} = Hub.change_feedback_type(feedback_type)
    end
  end

  describe "challenges" do
    alias DeeperHub.Hub.Challenge

    import DeeperHub.HubFixtures

    @invalid_attrs %{challenge_name: nil, challenge_description: nil, points_reward: nil, start_date: nil, end_date: nil}

    test "list_challenges/0 returns all challenges" do
      challenge = challenge_fixture()
      assert Hub.list_challenges() == [challenge]
    end

    test "get_challenge!/1 returns the challenge with given id" do
      challenge = challenge_fixture()
      assert Hub.get_challenge!(challenge.id) == challenge
    end

    test "create_challenge/1 with valid data creates a challenge" do
      valid_attrs = %{challenge_name: "some challenge_name", challenge_description: "some challenge_description", points_reward: 42, start_date: ~U[2025-06-20 17:59:00Z], end_date: ~U[2025-06-20 17:59:00Z]}

      assert {:ok, %Challenge{} = challenge} = Hub.create_challenge(valid_attrs)
      assert challenge.challenge_name == "some challenge_name"
      assert challenge.challenge_description == "some challenge_description"
      assert challenge.points_reward == 42
      assert challenge.start_date == ~U[2025-06-20 17:59:00Z]
      assert challenge.end_date == ~U[2025-06-20 17:59:00Z]
    end

    test "create_challenge/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Hub.create_challenge(@invalid_attrs)
    end

    test "update_challenge/2 with valid data updates the challenge" do
      challenge = challenge_fixture()
      update_attrs = %{challenge_name: "some updated challenge_name", challenge_description: "some updated challenge_description", points_reward: 43, start_date: ~U[2025-06-21 17:59:00Z], end_date: ~U[2025-06-21 17:59:00Z]}

      assert {:ok, %Challenge{} = challenge} = Hub.update_challenge(challenge, update_attrs)
      assert challenge.challenge_name == "some updated challenge_name"
      assert challenge.challenge_description == "some updated challenge_description"
      assert challenge.points_reward == 43
      assert challenge.start_date == ~U[2025-06-21 17:59:00Z]
      assert challenge.end_date == ~U[2025-06-21 17:59:00Z]
    end

    test "update_challenge/2 with invalid data returns error changeset" do
      challenge = challenge_fixture()
      assert {:error, %Ecto.Changeset{}} = Hub.update_challenge(challenge, @invalid_attrs)
      assert challenge == Hub.get_challenge!(challenge.id)
    end

    test "delete_challenge/1 deletes the challenge" do
      challenge = challenge_fixture()
      assert {:ok, %Challenge{}} = Hub.delete_challenge(challenge)
      assert_raise Ecto.NoResultsError, fn -> Hub.get_challenge!(challenge.id) end
    end

    test "change_challenge/1 returns a challenge changeset" do
      challenge = challenge_fixture()
      assert %Ecto.Changeset{} = Hub.change_challenge(challenge)
    end
  end

  describe "rewards" do
    alias DeeperHub.Hub.Reward

    import DeeperHub.HubFixtures

    @invalid_attrs %{reward_name: nil, reward_description: nil, points_required: nil}

    test "list_rewards/0 returns all rewards" do
      reward = reward_fixture()
      assert Hub.list_rewards() == [reward]
    end

    test "get_reward!/1 returns the reward with given id" do
      reward = reward_fixture()
      assert Hub.get_reward!(reward.id) == reward
    end

    test "create_reward/1 with valid data creates a reward" do
      valid_attrs = %{reward_name: "some reward_name", reward_description: "some reward_description", points_required: 42}

      assert {:ok, %Reward{} = reward} = Hub.create_reward(valid_attrs)
      assert reward.reward_name == "some reward_name"
      assert reward.reward_description == "some reward_description"
      assert reward.points_required == 42
    end

    test "create_reward/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Hub.create_reward(@invalid_attrs)
    end

    test "update_reward/2 with valid data updates the reward" do
      reward = reward_fixture()
      update_attrs = %{reward_name: "some updated reward_name", reward_description: "some updated reward_description", points_required: 43}

      assert {:ok, %Reward{} = reward} = Hub.update_reward(reward, update_attrs)
      assert reward.reward_name == "some updated reward_name"
      assert reward.reward_description == "some updated reward_description"
      assert reward.points_required == 43
    end

    test "update_reward/2 with invalid data returns error changeset" do
      reward = reward_fixture()
      assert {:error, %Ecto.Changeset{}} = Hub.update_reward(reward, @invalid_attrs)
      assert reward == Hub.get_reward!(reward.id)
    end

    test "delete_reward/1 deletes the reward" do
      reward = reward_fixture()
      assert {:ok, %Reward{}} = Hub.delete_reward(reward)
      assert_raise Ecto.NoResultsError, fn -> Hub.get_reward!(reward.id) end
    end

    test "change_reward/1 returns a reward changeset" do
      reward = reward_fixture()
      assert %Ecto.Changeset{} = Hub.change_reward(reward)
    end
  end

  describe "achievements" do
    alias DeeperHub.Hub.Achievement

    import DeeperHub.HubFixtures

    @invalid_attrs %{name: nil, description: nil, points: nil, icon: nil}

    test "list_achievements/0 returns all achievements" do
      achievement = achievement_fixture()
      assert Hub.list_achievements() == [achievement]
    end

    test "get_achievement!/1 returns the achievement with given id" do
      achievement = achievement_fixture()
      assert Hub.get_achievement!(achievement.id) == achievement
    end

    test "create_achievement/1 with valid data creates a achievement" do
      valid_attrs = %{name: "some name", description: "some description", points: 42, icon: "some icon"}

      assert {:ok, %Achievement{} = achievement} = Hub.create_achievement(valid_attrs)
      assert achievement.name == "some name"
      assert achievement.description == "some description"
      assert achievement.points == 42
      assert achievement.icon == "some icon"
    end

    test "create_achievement/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Hub.create_achievement(@invalid_attrs)
    end

    test "update_achievement/2 with valid data updates the achievement" do
      achievement = achievement_fixture()
      update_attrs = %{name: "some updated name", description: "some updated description", points: 43, icon: "some updated icon"}

      assert {:ok, %Achievement{} = achievement} = Hub.update_achievement(achievement, update_attrs)
      assert achievement.name == "some updated name"
      assert achievement.description == "some updated description"
      assert achievement.points == 43
      assert achievement.icon == "some updated icon"
    end

    test "update_achievement/2 with invalid data returns error changeset" do
      achievement = achievement_fixture()
      assert {:error, %Ecto.Changeset{}} = Hub.update_achievement(achievement, @invalid_attrs)
      assert achievement == Hub.get_achievement!(achievement.id)
    end

    test "delete_achievement/1 deletes the achievement" do
      achievement = achievement_fixture()
      assert {:ok, %Achievement{}} = Hub.delete_achievement(achievement)
      assert_raise Ecto.NoResultsError, fn -> Hub.get_achievement!(achievement.id) end
    end

    test "change_achievement/1 returns a achievement changeset" do
      achievement = achievement_fixture()
      assert %Ecto.Changeset{} = Hub.change_achievement(achievement)
    end
  end

  describe "user_feedback" do
    alias DeeperHub.Hub.UserFeedback

    import DeeperHub.HubFixtures

    @invalid_attrs %{feedback_text: nil, submitted_at: nil}

    test "list_user_feedback/0 returns all user_feedback" do
      user_feedback = user_feedback_fixture()
      assert Hub.list_user_feedback() == [user_feedback]
    end

    test "get_user_feedback!/1 returns the user_feedback with given id" do
      user_feedback = user_feedback_fixture()
      assert Hub.get_user_feedback!(user_feedback.id) == user_feedback
    end

    test "create_user_feedback/1 with valid data creates a user_feedback" do
      valid_attrs = %{feedback_text: "some feedback_text", submitted_at: ~U[2025-06-20 17:59:00Z]}

      assert {:ok, %UserFeedback{} = user_feedback} = Hub.create_user_feedback(valid_attrs)
      assert user_feedback.feedback_text == "some feedback_text"
      assert user_feedback.submitted_at == ~U[2025-06-20 17:59:00Z]
    end

    test "create_user_feedback/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Hub.create_user_feedback(@invalid_attrs)
    end

    test "update_user_feedback/2 with valid data updates the user_feedback" do
      user_feedback = user_feedback_fixture()
      update_attrs = %{feedback_text: "some updated feedback_text", submitted_at: ~U[2025-06-21 17:59:00Z]}

      assert {:ok, %UserFeedback{} = user_feedback} = Hub.update_user_feedback(user_feedback, update_attrs)
      assert user_feedback.feedback_text == "some updated feedback_text"
      assert user_feedback.submitted_at == ~U[2025-06-21 17:59:00Z]
    end

    test "update_user_feedback/2 with invalid data returns error changeset" do
      user_feedback = user_feedback_fixture()
      assert {:error, %Ecto.Changeset{}} = Hub.update_user_feedback(user_feedback, @invalid_attrs)
      assert user_feedback == Hub.get_user_feedback!(user_feedback.id)
    end

    test "delete_user_feedback/1 deletes the user_feedback" do
      user_feedback = user_feedback_fixture()
      assert {:ok, %UserFeedback{}} = Hub.delete_user_feedback(user_feedback)
      assert_raise Ecto.NoResultsError, fn -> Hub.get_user_feedback!(user_feedback.id) end
    end

    test "change_user_feedback/1 returns a user_feedback changeset" do
      user_feedback = user_feedback_fixture()
      assert %Ecto.Changeset{} = Hub.change_user_feedback(user_feedback)
    end
  end

  describe "server_invites" do
    alias DeeperHub.Hub.ServerInvite

    import DeeperHub.HubFixtures

    @invalid_attrs %{invite_code: nil, expires_at: nil}

    test "list_server_invites/0 returns all server_invites" do
      server_invite = server_invite_fixture()
      assert Hub.list_server_invites() == [server_invite]
    end

    test "get_server_invite!/1 returns the server_invite with given id" do
      server_invite = server_invite_fixture()
      assert Hub.get_server_invite!(server_invite.id) == server_invite
    end

    test "create_server_invite/1 with valid data creates a server_invite" do
      valid_attrs = %{invite_code: "some invite_code", expires_at: ~U[2025-06-20 17:59:00Z]}

      assert {:ok, %ServerInvite{} = server_invite} = Hub.create_server_invite(valid_attrs)
      assert server_invite.invite_code == "some invite_code"
      assert server_invite.expires_at == ~U[2025-06-20 17:59:00Z]
    end

    test "create_server_invite/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Hub.create_server_invite(@invalid_attrs)
    end

    test "update_server_invite/2 with valid data updates the server_invite" do
      server_invite = server_invite_fixture()
      update_attrs = %{invite_code: "some updated invite_code", expires_at: ~U[2025-06-21 17:59:00Z]}

      assert {:ok, %ServerInvite{} = server_invite} = Hub.update_server_invite(server_invite, update_attrs)
      assert server_invite.invite_code == "some updated invite_code"
      assert server_invite.expires_at == ~U[2025-06-21 17:59:00Z]
    end

    test "update_server_invite/2 with invalid data returns error changeset" do
      server_invite = server_invite_fixture()
      assert {:error, %Ecto.Changeset{}} = Hub.update_server_invite(server_invite, @invalid_attrs)
      assert server_invite == Hub.get_server_invite!(server_invite.id)
    end

    test "delete_server_invite/1 deletes the server_invite" do
      server_invite = server_invite_fixture()
      assert {:ok, %ServerInvite{}} = Hub.delete_server_invite(server_invite)
      assert_raise Ecto.NoResultsError, fn -> Hub.get_server_invite!(server_invite.id) end
    end

    test "change_server_invite/1 returns a server_invite changeset" do
      server_invite = server_invite_fixture()
      assert %Ecto.Changeset{} = Hub.change_server_invite(server_invite)
    end
  end

  describe "user_recommendations" do
    alias DeeperHub.Hub.UserRecommendation

    import DeeperHub.HubFixtures

    @invalid_attrs %{recommendation_score: nil}

    test "list_user_recommendations/0 returns all user_recommendations" do
      user_recommendation = user_recommendation_fixture()
      assert Hub.list_user_recommendations() == [user_recommendation]
    end

    test "get_user_recommendation!/1 returns the user_recommendation with given id" do
      user_recommendation = user_recommendation_fixture()
      assert Hub.get_user_recommendation!(user_recommendation.id) == user_recommendation
    end

    test "create_user_recommendation/1 with valid data creates a user_recommendation" do
      valid_attrs = %{recommendation_score: 120.5}

      assert {:ok, %UserRecommendation{} = user_recommendation} = Hub.create_user_recommendation(valid_attrs)
      assert user_recommendation.recommendation_score == 120.5
    end

    test "create_user_recommendation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Hub.create_user_recommendation(@invalid_attrs)
    end

    test "update_user_recommendation/2 with valid data updates the user_recommendation" do
      user_recommendation = user_recommendation_fixture()
      update_attrs = %{recommendation_score: 456.7}

      assert {:ok, %UserRecommendation{} = user_recommendation} = Hub.update_user_recommendation(user_recommendation, update_attrs)
      assert user_recommendation.recommendation_score == 456.7
    end

    test "update_user_recommendation/2 with invalid data returns error changeset" do
      user_recommendation = user_recommendation_fixture()
      assert {:error, %Ecto.Changeset{}} = Hub.update_user_recommendation(user_recommendation, @invalid_attrs)
      assert user_recommendation == Hub.get_user_recommendation!(user_recommendation.id)
    end

    test "delete_user_recommendation/1 deletes the user_recommendation" do
      user_recommendation = user_recommendation_fixture()
      assert {:ok, %UserRecommendation{}} = Hub.delete_user_recommendation(user_recommendation)
      assert_raise Ecto.NoResultsError, fn -> Hub.get_user_recommendation!(user_recommendation.id) end
    end

    test "change_user_recommendation/1 returns a user_recommendation changeset" do
      user_recommendation = user_recommendation_fixture()
      assert %Ecto.Changeset{} = Hub.change_user_recommendation(user_recommendation)
    end
  end

  describe "server_reputation" do
    alias DeeperHub.Hub.ServerReputation

    import DeeperHub.HubFixtures

    @invalid_attrs %{reputation_score: nil, last_updated: nil}

    test "list_server_reputation/0 returns all server_reputation" do
      server_reputation = server_reputation_fixture()
      assert Hub.list_server_reputation() == [server_reputation]
    end

    test "get_server_reputation!/1 returns the server_reputation with given id" do
      server_reputation = server_reputation_fixture()
      assert Hub.get_server_reputation!(server_reputation.id) == server_reputation
    end

    test "create_server_reputation/1 with valid data creates a server_reputation" do
      valid_attrs = %{reputation_score: 42, last_updated: ~U[2025-06-20 18:00:00Z]}

      assert {:ok, %ServerReputation{} = server_reputation} = Hub.create_server_reputation(valid_attrs)
      assert server_reputation.reputation_score == 42
      assert server_reputation.last_updated == ~U[2025-06-20 18:00:00Z]
    end

    test "create_server_reputation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Hub.create_server_reputation(@invalid_attrs)
    end

    test "update_server_reputation/2 with valid data updates the server_reputation" do
      server_reputation = server_reputation_fixture()
      update_attrs = %{reputation_score: 43, last_updated: ~U[2025-06-21 18:00:00Z]}

      assert {:ok, %ServerReputation{} = server_reputation} = Hub.update_server_reputation(server_reputation, update_attrs)
      assert server_reputation.reputation_score == 43
      assert server_reputation.last_updated == ~U[2025-06-21 18:00:00Z]
    end

    test "update_server_reputation/2 with invalid data returns error changeset" do
      server_reputation = server_reputation_fixture()
      assert {:error, %Ecto.Changeset{}} = Hub.update_server_reputation(server_reputation, @invalid_attrs)
      assert server_reputation == Hub.get_server_reputation!(server_reputation.id)
    end

    test "delete_server_reputation/1 deletes the server_reputation" do
      server_reputation = server_reputation_fixture()
      assert {:ok, %ServerReputation{}} = Hub.delete_server_reputation(server_reputation)
      assert_raise Ecto.NoResultsError, fn -> Hub.get_server_reputation!(server_reputation.id) end
    end

    test "change_server_reputation/1 returns a server_reputation changeset" do
      server_reputation = server_reputation_fixture()
      assert %Ecto.Changeset{} = Hub.change_server_reputation(server_reputation)
    end
  end

  describe "reports" do
    alias DeeperHub.Hub.Report

    import DeeperHub.HubFixtures

    @invalid_attrs %{report_type: nil, report_details: nil, reported_at: nil}

    test "list_reports/0 returns all reports" do
      report = report_fixture()
      assert Hub.list_reports() == [report]
    end

    test "get_report!/1 returns the report with given id" do
      report = report_fixture()
      assert Hub.get_report!(report.id) == report
    end

    test "create_report/1 with valid data creates a report" do
      valid_attrs = %{report_type: "some report_type", report_details: "some report_details", reported_at: ~U[2025-06-20 18:00:00Z]}

      assert {:ok, %Report{} = report} = Hub.create_report(valid_attrs)
      assert report.report_type == "some report_type"
      assert report.report_details == "some report_details"
      assert report.reported_at == ~U[2025-06-20 18:00:00Z]
    end

    test "create_report/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Hub.create_report(@invalid_attrs)
    end

    test "update_report/2 with valid data updates the report" do
      report = report_fixture()
      update_attrs = %{report_type: "some updated report_type", report_details: "some updated report_details", reported_at: ~U[2025-06-21 18:00:00Z]}

      assert {:ok, %Report{} = report} = Hub.update_report(report, update_attrs)
      assert report.report_type == "some updated report_type"
      assert report.report_details == "some updated report_details"
      assert report.reported_at == ~U[2025-06-21 18:00:00Z]
    end

    test "update_report/2 with invalid data returns error changeset" do
      report = report_fixture()
      assert {:error, %Ecto.Changeset{}} = Hub.update_report(report, @invalid_attrs)
      assert report == Hub.get_report!(report.id)
    end

    test "delete_report/1 deletes the report" do
      report = report_fixture()
      assert {:ok, %Report{}} = Hub.delete_report(report)
      assert_raise Ecto.NoResultsError, fn -> Hub.get_report!(report.id) end
    end

    test "change_report/1 returns a report changeset" do
      report = report_fixture()
      assert %Ecto.Changeset{} = Hub.change_report(report)
    end
  end

  describe "advertisements" do
    alias DeeperHub.Hub.ServerAdvertisement

    import DeeperHub.HubFixtures

    @invalid_attrs %{ad_title: nil, ad_description: nil, start_date: nil, end_date: nil}

    test "list_advertisements/0 returns all advertisements" do
      server_advertisement = server_advertisement_fixture()
      assert Hub.list_advertisements() == [server_advertisement]
    end

    test "get_server_advertisement!/1 returns the server_advertisement with given id" do
      server_advertisement = server_advertisement_fixture()
      assert Hub.get_server_advertisement!(server_advertisement.id) == server_advertisement
    end

    test "create_server_advertisement/1 with valid data creates a server_advertisement" do
      valid_attrs = %{ad_title: "some ad_title", ad_description: "some ad_description", start_date: ~U[2025-06-20 18:00:00Z], end_date: ~U[2025-06-20 18:00:00Z]}

      assert {:ok, %ServerAdvertisement{} = server_advertisement} = Hub.create_server_advertisement(valid_attrs)
      assert server_advertisement.ad_title == "some ad_title"
      assert server_advertisement.ad_description == "some ad_description"
      assert server_advertisement.start_date == ~U[2025-06-20 18:00:00Z]
      assert server_advertisement.end_date == ~U[2025-06-20 18:00:00Z]
    end

    test "create_server_advertisement/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Hub.create_server_advertisement(@invalid_attrs)
    end

    test "update_server_advertisement/2 with valid data updates the server_advertisement" do
      server_advertisement = server_advertisement_fixture()
      update_attrs = %{ad_title: "some updated ad_title", ad_description: "some updated ad_description", start_date: ~U[2025-06-21 18:00:00Z], end_date: ~U[2025-06-21 18:00:00Z]}

      assert {:ok, %ServerAdvertisement{} = server_advertisement} = Hub.update_server_advertisement(server_advertisement, update_attrs)
      assert server_advertisement.ad_title == "some updated ad_title"
      assert server_advertisement.ad_description == "some updated ad_description"
      assert server_advertisement.start_date == ~U[2025-06-21 18:00:00Z]
      assert server_advertisement.end_date == ~U[2025-06-21 18:00:00Z]
    end

    test "update_server_advertisement/2 with invalid data returns error changeset" do
      server_advertisement = server_advertisement_fixture()
      assert {:error, %Ecto.Changeset{}} = Hub.update_server_advertisement(server_advertisement, @invalid_attrs)
      assert server_advertisement == Hub.get_server_advertisement!(server_advertisement.id)
    end

    test "delete_server_advertisement/1 deletes the server_advertisement" do
      server_advertisement = server_advertisement_fixture()
      assert {:ok, %ServerAdvertisement{}} = Hub.delete_server_advertisement(server_advertisement)
      assert_raise Ecto.NoResultsError, fn -> Hub.get_server_advertisement!(server_advertisement.id) end
    end

    test "change_server_advertisement/1 returns a server_advertisement changeset" do
      server_advertisement = server_advertisement_fixture()
      assert %Ecto.Changeset{} = Hub.change_server_advertisement(server_advertisement)
    end
  end

  describe "support_tickets" do
    alias DeeperHub.Hub.SupportTicket

    import DeeperHub.HubFixtures

    @invalid_attrs %{status: nil, issue_description: nil}

    test "list_support_tickets/0 returns all support_tickets" do
      support_ticket = support_ticket_fixture()
      assert Hub.list_support_tickets() == [support_ticket]
    end

    test "get_support_ticket!/1 returns the support_ticket with given id" do
      support_ticket = support_ticket_fixture()
      assert Hub.get_support_ticket!(support_ticket.id) == support_ticket
    end

    test "create_support_ticket/1 with valid data creates a support_ticket" do
      valid_attrs = %{status: "some status", issue_description: "some issue_description"}

      assert {:ok, %SupportTicket{} = support_ticket} = Hub.create_support_ticket(valid_attrs)
      assert support_ticket.status == "some status"
      assert support_ticket.issue_description == "some issue_description"
    end

    test "create_support_ticket/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Hub.create_support_ticket(@invalid_attrs)
    end

    test "update_support_ticket/2 with valid data updates the support_ticket" do
      support_ticket = support_ticket_fixture()
      update_attrs = %{status: "some updated status", issue_description: "some updated issue_description"}

      assert {:ok, %SupportTicket{} = support_ticket} = Hub.update_support_ticket(support_ticket, update_attrs)
      assert support_ticket.status == "some updated status"
      assert support_ticket.issue_description == "some updated issue_description"
    end

    test "update_support_ticket/2 with invalid data returns error changeset" do
      support_ticket = support_ticket_fixture()
      assert {:error, %Ecto.Changeset{}} = Hub.update_support_ticket(support_ticket, @invalid_attrs)
      assert support_ticket == Hub.get_support_ticket!(support_ticket.id)
    end

    test "delete_support_ticket/1 deletes the support_ticket" do
      support_ticket = support_ticket_fixture()
      assert {:ok, %SupportTicket{}} = Hub.delete_support_ticket(support_ticket)
      assert_raise Ecto.NoResultsError, fn -> Hub.get_support_ticket!(support_ticket.id) end
    end

    test "change_support_ticket/1 returns a support_ticket changeset" do
      support_ticket = support_ticket_fixture()
      assert %Ecto.Changeset{} = Hub.change_support_ticket(support_ticket)
    end
  end

  describe "reviews" do
    alias DeeperHub.Hub.ServerReview

    import DeeperHub.HubFixtures

    @invalid_attrs %{comments: nil, rating: nil}

    test "list_reviews/0 returns all reviews" do
      server_review = server_review_fixture()
      assert Hub.list_reviews() == [server_review]
    end

    test "get_server_review!/1 returns the server_review with given id" do
      server_review = server_review_fixture()
      assert Hub.get_server_review!(server_review.id) == server_review
    end

    test "create_server_review/1 with valid data creates a server_review" do
      valid_attrs = %{comments: "some comments", rating: 42}

      assert {:ok, %ServerReview{} = server_review} = Hub.create_server_review(valid_attrs)
      assert server_review.comments == "some comments"
      assert server_review.rating == 42
    end

    test "create_server_review/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Hub.create_server_review(@invalid_attrs)
    end

    test "update_server_review/2 with valid data updates the server_review" do
      server_review = server_review_fixture()
      update_attrs = %{comments: "some updated comments", rating: 43}

      assert {:ok, %ServerReview{} = server_review} = Hub.update_server_review(server_review, update_attrs)
      assert server_review.comments == "some updated comments"
      assert server_review.rating == 43
    end

    test "update_server_review/2 with invalid data returns error changeset" do
      server_review = server_review_fixture()
      assert {:error, %Ecto.Changeset{}} = Hub.update_server_review(server_review, @invalid_attrs)
      assert server_review == Hub.get_server_review!(server_review.id)
    end

    test "delete_server_review/1 deletes the server_review" do
      server_review = server_review_fixture()
      assert {:ok, %ServerReview{}} = Hub.delete_server_review(server_review)
      assert_raise Ecto.NoResultsError, fn -> Hub.get_server_review!(server_review.id) end
    end

    test "change_server_review/1 returns a server_review changeset" do
      server_review = server_review_fixture()
      assert %Ecto.Changeset{} = Hub.change_server_review(server_review)
    end
  end

  describe "ratings" do
    alias DeeperHub.Hub.Rating

    import DeeperHub.HubFixtures

    @invalid_attrs %{rating: nil}

    test "list_ratings/0 returns all ratings" do
      rating = rating_fixture()
      assert Hub.list_ratings() == [rating]
    end

    test "get_rating!/1 returns the rating with given id" do
      rating = rating_fixture()
      assert Hub.get_rating!(rating.id) == rating
    end

    test "create_rating/1 with valid data creates a rating" do
      valid_attrs = %{rating: 42}

      assert {:ok, %Rating{} = rating} = Hub.create_rating(valid_attrs)
      assert rating.rating == 42
    end

    test "create_rating/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Hub.create_rating(@invalid_attrs)
    end

    test "update_rating/2 with valid data updates the rating" do
      rating = rating_fixture()
      update_attrs = %{rating: 43}

      assert {:ok, %Rating{} = rating} = Hub.update_rating(rating, update_attrs)
      assert rating.rating == 43
    end

    test "update_rating/2 with invalid data returns error changeset" do
      rating = rating_fixture()
      assert {:error, %Ecto.Changeset{}} = Hub.update_rating(rating, @invalid_attrs)
      assert rating == Hub.get_rating!(rating.id)
    end

    test "delete_rating/1 deletes the rating" do
      rating = rating_fixture()
      assert {:ok, %Rating{}} = Hub.delete_rating(rating)
      assert_raise Ecto.NoResultsError, fn -> Hub.get_rating!(rating.id) end
    end

    test "change_rating/1 returns a rating changeset" do
      rating = rating_fixture()
      assert %Ecto.Changeset{} = Hub.change_rating(rating)
    end
  end

  describe "server_tags" do
    alias DeeperHub.Hub.ServerTag

    import DeeperHub.HubFixtures

    @invalid_attrs %{tag: nil}

    test "list_server_tags/0 returns all server_tags" do
      server_tag = server_tag_fixture()
      assert Hub.list_server_tags() == [server_tag]
    end

    test "get_server_tag!/1 returns the server_tag with given id" do
      server_tag = server_tag_fixture()
      assert Hub.get_server_tag!(server_tag.id) == server_tag
    end

    test "create_server_tag/1 with valid data creates a server_tag" do
      valid_attrs = %{tag: "some tag"}

      assert {:ok, %ServerTag{} = server_tag} = Hub.create_server_tag(valid_attrs)
      assert server_tag.tag == "some tag"
    end

    test "create_server_tag/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Hub.create_server_tag(@invalid_attrs)
    end

    test "update_server_tag/2 with valid data updates the server_tag" do
      server_tag = server_tag_fixture()
      update_attrs = %{tag: "some updated tag"}

      assert {:ok, %ServerTag{} = server_tag} = Hub.update_server_tag(server_tag, update_attrs)
      assert server_tag.tag == "some updated tag"
    end

    test "update_server_tag/2 with invalid data returns error changeset" do
      server_tag = server_tag_fixture()
      assert {:error, %Ecto.Changeset{}} = Hub.update_server_tag(server_tag, @invalid_attrs)
      assert server_tag == Hub.get_server_tag!(server_tag.id)
    end

    test "delete_server_tag/1 deletes the server_tag" do
      server_tag = server_tag_fixture()
      assert {:ok, %ServerTag{}} = Hub.delete_server_tag(server_tag)
      assert_raise Ecto.NoResultsError, fn -> Hub.get_server_tag!(server_tag.id) end
    end

    test "change_server_tag/1 returns a server_tag changeset" do
      server_tag = server_tag_fixture()
      assert %Ecto.Changeset{} = Hub.change_server_tag(server_tag)
    end
  end

  describe "events" do
    alias DeeperHub.Hub.ServerEvent

    import DeeperHub.HubFixtures

    @invalid_attrs %{description: nil, title: nil, start_time: nil, end_time: nil, is_active: nil}

    test "list_events/0 returns all events" do
      server_event = server_event_fixture()
      assert Hub.list_events() == [server_event]
    end

    test "get_server_event!/1 returns the server_event with given id" do
      server_event = server_event_fixture()
      assert Hub.get_server_event!(server_event.id) == server_event
    end

    test "create_server_event/1 with valid data creates a server_event" do
      valid_attrs = %{description: "some description", title: "some title", start_time: ~U[2025-06-20 18:25:00Z], end_time: ~U[2025-06-20 18:25:00Z], is_active: true}

      assert {:ok, %ServerEvent{} = server_event} = Hub.create_server_event(valid_attrs)
      assert server_event.description == "some description"
      assert server_event.title == "some title"
      assert server_event.start_time == ~U[2025-06-20 18:25:00Z]
      assert server_event.end_time == ~U[2025-06-20 18:25:00Z]
      assert server_event.is_active == true
    end

    test "create_server_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Hub.create_server_event(@invalid_attrs)
    end

    test "update_server_event/2 with valid data updates the server_event" do
      server_event = server_event_fixture()
      update_attrs = %{description: "some updated description", title: "some updated title", start_time: ~U[2025-06-21 18:25:00Z], end_time: ~U[2025-06-21 18:25:00Z], is_active: false}

      assert {:ok, %ServerEvent{} = server_event} = Hub.update_server_event(server_event, update_attrs)
      assert server_event.description == "some updated description"
      assert server_event.title == "some updated title"
      assert server_event.start_time == ~U[2025-06-21 18:25:00Z]
      assert server_event.end_time == ~U[2025-06-21 18:25:00Z]
      assert server_event.is_active == false
    end

    test "update_server_event/2 with invalid data returns error changeset" do
      server_event = server_event_fixture()
      assert {:error, %Ecto.Changeset{}} = Hub.update_server_event(server_event, @invalid_attrs)
      assert server_event == Hub.get_server_event!(server_event.id)
    end

    test "delete_server_event/1 deletes the server_event" do
      server_event = server_event_fixture()
      assert {:ok, %ServerEvent{}} = Hub.delete_server_event(server_event)
      assert_raise Ecto.NoResultsError, fn -> Hub.get_server_event!(server_event.id) end
    end

    test "change_server_event/1 returns a server_event changeset" do
      server_event = server_event_fixture()
      assert %Ecto.Changeset{} = Hub.change_server_event(server_event)
    end
  end

  describe "server_update_messages" do
    alias DeeperHub.Hub.ServerUpdateMessage

    import DeeperHub.HubFixtures

    @invalid_attrs %{update_notes: nil, new_version: nil, screenshoots: nil, update_date: nil}

    test "list_server_update_messages/0 returns all server_update_messages" do
      server_update_message = server_update_message_fixture()
      assert Hub.list_server_update_messages() == [server_update_message]
    end

    test "get_server_update_message!/1 returns the server_update_message with given id" do
      server_update_message = server_update_message_fixture()
      assert Hub.get_server_update_message!(server_update_message.id) == server_update_message
    end

    test "create_server_update_message/1 with valid data creates a server_update_message" do
      valid_attrs = %{update_notes: "some update_notes", new_version: "some new_version", screenshoots: "some screenshoots", update_date: ~U[2025-06-20 18:25:00Z]}

      assert {:ok, %ServerUpdateMessage{} = server_update_message} = Hub.create_server_update_message(valid_attrs)
      assert server_update_message.update_notes == "some update_notes"
      assert server_update_message.new_version == "some new_version"
      assert server_update_message.screenshoots == "some screenshoots"
      assert server_update_message.update_date == ~U[2025-06-20 18:25:00Z]
    end

    test "create_server_update_message/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Hub.create_server_update_message(@invalid_attrs)
    end

    test "update_server_update_message/2 with valid data updates the server_update_message" do
      server_update_message = server_update_message_fixture()
      update_attrs = %{update_notes: "some updated update_notes", new_version: "some updated new_version", screenshoots: "some updated screenshoots", update_date: ~U[2025-06-21 18:25:00Z]}

      assert {:ok, %ServerUpdateMessage{} = server_update_message} = Hub.update_server_update_message(server_update_message, update_attrs)
      assert server_update_message.update_notes == "some updated update_notes"
      assert server_update_message.new_version == "some updated new_version"
      assert server_update_message.screenshoots == "some updated screenshoots"
      assert server_update_message.update_date == ~U[2025-06-21 18:25:00Z]
    end

    test "update_server_update_message/2 with invalid data returns error changeset" do
      server_update_message = server_update_message_fixture()
      assert {:error, %Ecto.Changeset{}} = Hub.update_server_update_message(server_update_message, @invalid_attrs)
      assert server_update_message == Hub.get_server_update_message!(server_update_message.id)
    end

    test "delete_server_update_message/1 deletes the server_update_message" do
      server_update_message = server_update_message_fixture()
      assert {:ok, %ServerUpdateMessage{}} = Hub.delete_server_update_message(server_update_message)
      assert_raise Ecto.NoResultsError, fn -> Hub.get_server_update_message!(server_update_message.id) end
    end

    test "change_server_update_message/1 returns a server_update_message changeset" do
      server_update_message = server_update_message_fixture()
      assert %Ecto.Changeset{} = Hub.change_server_update_message(server_update_message)
    end
  end
end

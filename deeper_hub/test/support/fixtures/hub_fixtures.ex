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

  @doc """
  Generate a achievement_type.
  """
  def achievement_type_fixture(attrs \\ %{}) do
    {:ok, achievement_type} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name"
      })
      |> DeeperHub.Hub.create_achievement_type()

    achievement_type
  end

  @doc """
  Generate a feedback_type.
  """
  def feedback_type_fixture(attrs \\ %{}) do
    {:ok, feedback_type} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name"
      })
      |> DeeperHub.Hub.create_feedback_type()

    feedback_type
  end

  @doc """
  Generate a challenge.
  """
  def challenge_fixture(attrs \\ %{}) do
    {:ok, challenge} =
      attrs
      |> Enum.into(%{
        challenge_description: "some challenge_description",
        challenge_name: "some challenge_name",
        end_date: ~U[2025-06-20 17:59:00Z],
        points_reward: 42,
        start_date: ~U[2025-06-20 17:59:00Z]
      })
      |> DeeperHub.Hub.create_challenge()

    challenge
  end

  @doc """
  Generate a reward.
  """
  def reward_fixture(attrs \\ %{}) do
    {:ok, reward} =
      attrs
      |> Enum.into(%{
        points_required: 42,
        reward_description: "some reward_description",
        reward_name: "some reward_name"
      })
      |> DeeperHub.Hub.create_reward()

    reward
  end

  @doc """
  Generate a achievement.
  """
  def achievement_fixture(attrs \\ %{}) do
    {:ok, achievement} =
      attrs
      |> Enum.into(%{
        description: "some description",
        icon: "some icon",
        name: "some name",
        points: 42
      })
      |> DeeperHub.Hub.create_achievement()

    achievement
  end

  @doc """
  Generate a user_feedback.
  """
  def user_feedback_fixture(attrs \\ %{}) do
    {:ok, user_feedback} =
      attrs
      |> Enum.into(%{
        feedback_text: "some feedback_text",
        submitted_at: ~U[2025-06-20 17:59:00Z]
      })
      |> DeeperHub.Hub.create_user_feedback()

    user_feedback
  end

  @doc """
  Generate a server_invite.
  """
  def server_invite_fixture(attrs \\ %{}) do
    {:ok, server_invite} =
      attrs
      |> Enum.into(%{
        expires_at: ~U[2025-06-20 17:59:00Z],
        invite_code: "some invite_code"
      })
      |> DeeperHub.Hub.create_server_invite()

    server_invite
  end

  @doc """
  Generate a user_recommendation.
  """
  def user_recommendation_fixture(attrs \\ %{}) do
    {:ok, user_recommendation} =
      attrs
      |> Enum.into(%{
        recommendation_score: 120.5
      })
      |> DeeperHub.Hub.create_user_recommendation()

    user_recommendation
  end

  @doc """
  Generate a server_reputation.
  """
  def server_reputation_fixture(attrs \\ %{}) do
    {:ok, server_reputation} =
      attrs
      |> Enum.into(%{
        last_updated: ~U[2025-06-20 18:00:00Z],
        reputation_score: 42
      })
      |> DeeperHub.Hub.create_server_reputation()

    server_reputation
  end

  @doc """
  Generate a report.
  """
  def report_fixture(attrs \\ %{}) do
    {:ok, report} =
      attrs
      |> Enum.into(%{
        report_details: "some report_details",
        report_type: "some report_type",
        reported_at: ~U[2025-06-20 18:00:00Z]
      })
      |> DeeperHub.Hub.create_report()

    report
  end

  @doc """
  Generate a server_advertisement.
  """
  def server_advertisement_fixture(attrs \\ %{}) do
    {:ok, server_advertisement} =
      attrs
      |> Enum.into(%{
        ad_description: "some ad_description",
        ad_title: "some ad_title",
        end_date: ~U[2025-06-20 18:00:00Z],
        start_date: ~U[2025-06-20 18:00:00Z]
      })
      |> DeeperHub.Hub.create_server_advertisement()

    server_advertisement
  end

  @doc """
  Generate a support_ticket.
  """
  def support_ticket_fixture(attrs \\ %{}) do
    {:ok, support_ticket} =
      attrs
      |> Enum.into(%{
        issue_description: "some issue_description",
        status: "some status"
      })
      |> DeeperHub.Hub.create_support_ticket()

    support_ticket
  end

  @doc """
  Generate a server_review.
  """
  def server_review_fixture(attrs \\ %{}) do
    {:ok, server_review} =
      attrs
      |> Enum.into(%{
        comments: "some comments",
        rating: 42
      })
      |> DeeperHub.Hub.create_server_review()

    server_review
  end

  @doc """
  Generate a rating.
  """
  def rating_fixture(attrs \\ %{}) do
    {:ok, rating} =
      attrs
      |> Enum.into(%{
        rating: 42
      })
      |> DeeperHub.Hub.create_rating()

    rating
  end

  @doc """
  Generate a server_tag.
  """
  def server_tag_fixture(attrs \\ %{}) do
    {:ok, server_tag} =
      attrs
      |> Enum.into(%{
        tag: "some tag"
      })
      |> DeeperHub.Hub.create_server_tag()

    server_tag
  end

  @doc """
  Generate a server_event.
  """
  def server_event_fixture(attrs \\ %{}) do
    {:ok, server_event} =
      attrs
      |> Enum.into(%{
        description: "some description",
        end_time: ~U[2025-06-20 18:25:00Z],
        is_active: true,
        start_time: ~U[2025-06-20 18:25:00Z],
        title: "some title"
      })
      |> DeeperHub.Hub.create_server_event()

    server_event
  end

  @doc """
  Generate a server_update_message.
  """
  def server_update_message_fixture(attrs \\ %{}) do
    {:ok, server_update_message} =
      attrs
      |> Enum.into(%{
        new_version: "some new_version",
        screenshoots: "some screenshoots",
        update_date: ~U[2025-06-20 18:25:00Z],
        update_notes: "some update_notes"
      })
      |> DeeperHub.Hub.create_server_update_message()

    server_update_message
  end
end

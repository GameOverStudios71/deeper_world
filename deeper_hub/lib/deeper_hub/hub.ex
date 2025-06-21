defmodule DeeperHub.Hub do
  @moduledoc """
  The Hub context.
  """

  import Ecto.Query, warn: false
  alias DeeperHub.Repo

  alias DeeperHub.Hub.Language

  @doc """
  Returns the list of languages.

  ## Examples

      iex> list_languages()
      [%Language{}, ...]

  """
  def list_languages do
    Repo.all(Language)
  end

  @doc """
  Gets a single language.

  Raises `Ecto.NoResultsError` if the Language does not exist.

  ## Examples

      iex> get_language!(123)
      %Language{}

      iex> get_language!(456)
      ** (Ecto.NoResultsError)

  """
  def get_language!(id), do: Repo.get!(Language, id)

  @doc """
  Creates a language.

  ## Examples

      iex> create_language(%{field: value})
      {:ok, %Language{}}

      iex> create_language(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_language(attrs \\ %{}) do
    %Language{}
    |> Language.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a language.

  ## Examples

      iex> update_language(language, %{field: new_value})
      {:ok, %Language{}}

      iex> update_language(language, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_language(%Language{} = language, attrs) do
    language
    |> Language.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a language.

  ## Examples

      iex> delete_language(language)
      {:ok, %Language{}}

      iex> delete_language(language)
      {:error, %Ecto.Changeset{}}

  """
  def delete_language(%Language{} = language) do
    Repo.delete(language)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking language changes.

  ## Examples

      iex> change_language(language)
      %Ecto.Changeset{data: %Language{}}

  """
  def change_language(%Language{} = language, attrs \\ %{}) do
    Language.changeset(language, attrs)
  end

  alias DeeperHub.Hub.Category

  @doc """
  Returns the list of categories.

  ## Examples

      iex> list_categories()
      [%Category{}, ...]

  """
  def list_categories do
    Repo.all(Category)
  end

  @doc """
  Gets a single category.

  Raises `Ecto.NoResultsError` if the Category does not exist.

  ## Examples

      iex> get_category!(123)
      %Category{}

      iex> get_category!(456)
      ** (Ecto.NoResultsError)

  """
  def get_category!(id), do: Repo.get!(Category, id)

  @doc """
  Creates a category.

  ## Examples

      iex> create_category(%{field: value})
      {:ok, %Category{}}

      iex> create_category(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_category(attrs \\ %{}) do
    %Category{}
    |> Category.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a category.

  ## Examples

      iex> update_category(category, %{field: new_value})
      {:ok, %Category{}}

      iex> update_category(category, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_category(%Category{} = category, attrs) do
    category
    |> Category.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a category.

  ## Examples

      iex> delete_category(category)
      {:ok, %Category{}}

      iex> delete_category(category)
      {:error, %Ecto.Changeset{}}

  """
  def delete_category(%Category{} = category) do
    Repo.delete(category)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking category changes.

  ## Examples

      iex> change_category(category)
      %Ecto.Changeset{data: %Category{}}

  """
  def change_category(%Category{} = category, attrs \\ %{}) do
    Category.changeset(category, attrs)
  end

  alias DeeperHub.Hub.Status

  @doc """
  Returns the list of statuses.

  ## Examples

      iex> list_statuses()
      [%Status{}, ...]

  """
  def list_statuses do
    Repo.all(Status)
  end

  @doc """
  Gets a single status.

  Raises `Ecto.NoResultsError` if the Status does not exist.

  ## Examples

      iex> get_status!(123)
      %Status{}

      iex> get_status!(456)
      ** (Ecto.NoResultsError)

  """
  def get_status!(id), do: Repo.get!(Status, id)

  @doc """
  Creates a status.

  ## Examples

      iex> create_status(%{field: value})
      {:ok, %Status{}}

      iex> create_status(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_status(attrs \\ %{}) do
    %Status{}
    |> Status.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a status.

  ## Examples

      iex> update_status(status, %{field: new_value})
      {:ok, %Status{}}

      iex> update_status(status, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_status(%Status{} = status, attrs) do
    status
    |> Status.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a status.

  ## Examples

      iex> delete_status(status)
      {:ok, %Status{}}

      iex> delete_status(status)
      {:error, %Ecto.Changeset{}}

  """
  def delete_status(%Status{} = status) do
    Repo.delete(status)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking status changes.

  ## Examples

      iex> change_status(status)
      %Ecto.Changeset{data: %Status{}}

  """
  def change_status(%Status{} = status, attrs \\ %{}) do
    Status.changeset(status, attrs)
  end

  alias DeeperHub.Hub.Engine

  @doc """
  Returns the list of engines.

  ## Examples

      iex> list_engines()
      [%Engine{}, ...]

  """
  def list_engines do
    Repo.all(Engine)
  end

  @doc """
  Gets a single engine.

  Raises `Ecto.NoResultsError` if the Engine does not exist.

  ## Examples

      iex> get_engine!(123)
      %Engine{}

      iex> get_engine!(456)
      ** (Ecto.NoResultsError)

  """
  def get_engine!(id), do: Repo.get!(Engine, id)

  @doc """
  Creates a engine.

  ## Examples

      iex> create_engine(%{field: value})
      {:ok, %Engine{}}

      iex> create_engine(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_engine(attrs \\ %{}) do
    %Engine{}
    |> Engine.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a engine.

  ## Examples

      iex> update_engine(engine, %{field: new_value})
      {:ok, %Engine{}}

      iex> update_engine(engine, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_engine(%Engine{} = engine, attrs) do
    engine
    |> Engine.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a engine.

  ## Examples

      iex> delete_engine(engine)
      {:ok, %Engine{}}

      iex> delete_engine(engine)
      {:error, %Ecto.Changeset{}}

  """
  def delete_engine(%Engine{} = engine) do
    Repo.delete(engine)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking engine changes.

  ## Examples

      iex> change_engine(engine)
      %Ecto.Changeset{data: %Engine{}}

  """
  def change_engine(%Engine{} = engine, attrs \\ %{}) do
    Engine.changeset(engine, attrs)
  end

  alias DeeperHub.Hub.Network

  @doc """
  Returns the list of networks.

  ## Examples

      iex> list_networks()
      [%Network{}, ...]

  """
  def list_networks do
    Repo.all(Network)
  end

  @doc """
  Gets a single network.

  Raises `Ecto.NoResultsError` if the Network does not exist.

  ## Examples

      iex> get_network!(123)
      %Network{}

      iex> get_network!(456)
      ** (Ecto.NoResultsError)

  """
  def get_network!(id), do: Repo.get!(Network, id)

  @doc """
  Creates a network.

  ## Examples

      iex> create_network(%{field: value})
      {:ok, %Network{}}

      iex> create_network(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_network(attrs \\ %{}) do
    %Network{}
    |> Network.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a network.

  ## Examples

      iex> update_network(network, %{field: new_value})
      {:ok, %Network{}}

      iex> update_network(network, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_network(%Network{} = network, attrs) do
    network
    |> Network.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a network.

  ## Examples

      iex> delete_network(network)
      {:ok, %Network{}}

      iex> delete_network(network)
      {:error, %Ecto.Changeset{}}

  """
  def delete_network(%Network{} = network) do
    Repo.delete(network)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking network changes.

  ## Examples

      iex> change_network(network)
      %Ecto.Changeset{data: %Network{}}

  """
  def change_network(%Network{} = network, attrs \\ %{}) do
    Network.changeset(network, attrs)
  end

  alias DeeperHub.Hub.ContentType

  @doc """
  Returns the list of content_types.

  ## Examples

      iex> list_content_types()
      [%ContentType{}, ...]

  """
  def list_content_types do
    Repo.all(ContentType)
  end

  @doc """
  Gets a single content_type.

  Raises `Ecto.NoResultsError` if the Content type does not exist.

  ## Examples

      iex> get_content_type!(123)
      %ContentType{}

      iex> get_content_type!(456)
      ** (Ecto.NoResultsError)

  """
  def get_content_type!(id), do: Repo.get!(ContentType, id)

  @doc """
  Creates a content_type.

  ## Examples

      iex> create_content_type(%{field: value})
      {:ok, %ContentType{}}

      iex> create_content_type(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_content_type(attrs \\ %{}) do
    %ContentType{}
    |> ContentType.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a content_type.

  ## Examples

      iex> update_content_type(content_type, %{field: new_value})
      {:ok, %ContentType{}}

      iex> update_content_type(content_type, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_content_type(%ContentType{} = content_type, attrs) do
    content_type
    |> ContentType.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a content_type.

  ## Examples

      iex> delete_content_type(content_type)
      {:ok, %ContentType{}}

      iex> delete_content_type(content_type)
      {:error, %Ecto.Changeset{}}

  """
  def delete_content_type(%ContentType{} = content_type) do
    Repo.delete(content_type)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking content_type changes.

  ## Examples

      iex> change_content_type(content_type)
      %Ecto.Changeset{data: %ContentType{}}

  """
  def change_content_type(%ContentType{} = content_type, attrs \\ %{}) do
    ContentType.changeset(content_type, attrs)
  end

  alias DeeperHub.Hub.Server

  @doc """
  Returns the list of servers.

  ## Examples

      iex> list_servers()
      [%Server{}, ...]

  """
  def list_servers do
    Repo.all(Server)
  end

  @doc """
  Gets a single server.

  Raises `Ecto.NoResultsError` if the Server does not exist.

  ## Examples

      iex> get_server!(123)
      %Server{}

      iex> get_server!(456)
      ** (Ecto.NoResultsError)

  """
  def get_server!(id), do: Repo.get!(Server, id)

  @doc """
  Creates a server.

  ## Examples

      iex> create_server(%{field: value})
      {:ok, %Server{}}

      iex> create_server(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_server(attrs \\ %{}) do
    %Server{}
    |> Server.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a server.

  ## Examples

      iex> update_server(server, %{field: new_value})
      {:ok, %Server{}}

      iex> update_server(server, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_server(%Server{} = server, attrs) do
    server
    |> Server.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a server.

  ## Examples

      iex> delete_server(server)
      {:ok, %Server{}}

      iex> delete_server(server)
      {:error, %Ecto.Changeset{}}

  """
  def delete_server(%Server{} = server) do
    Repo.delete(server)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking server changes.

  ## Examples

      iex> change_server(server)
      %Ecto.Changeset{data: %Server{}}

  """
  def change_server(%Server{} = server, attrs \\ %{}) do
    Server.changeset(server, attrs)
  end

  alias DeeperHub.Hub.AchievementType

  @doc """
  Returns the list of achievement_types.

  ## Examples

      iex> list_achievement_types()
      [%AchievementType{}, ...]

  """
  def list_achievement_types do
    Repo.all(AchievementType)
  end

  @doc """
  Gets a single achievement_type.

  Raises `Ecto.NoResultsError` if the Achievement type does not exist.

  ## Examples

      iex> get_achievement_type!(123)
      %AchievementType{}

      iex> get_achievement_type!(456)
      ** (Ecto.NoResultsError)

  """
  def get_achievement_type!(id), do: Repo.get!(AchievementType, id)

  @doc """
  Creates a achievement_type.

  ## Examples

      iex> create_achievement_type(%{field: value})
      {:ok, %AchievementType{}}

      iex> create_achievement_type(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_achievement_type(attrs \\ %{}) do
    %AchievementType{}
    |> AchievementType.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a achievement_type.

  ## Examples

      iex> update_achievement_type(achievement_type, %{field: new_value})
      {:ok, %AchievementType{}}

      iex> update_achievement_type(achievement_type, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_achievement_type(%AchievementType{} = achievement_type, attrs) do
    achievement_type
    |> AchievementType.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a achievement_type.

  ## Examples

      iex> delete_achievement_type(achievement_type)
      {:ok, %AchievementType{}}

      iex> delete_achievement_type(achievement_type)
      {:error, %Ecto.Changeset{}}

  """
  def delete_achievement_type(%AchievementType{} = achievement_type) do
    Repo.delete(achievement_type)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking achievement_type changes.

  ## Examples

      iex> change_achievement_type(achievement_type)
      %Ecto.Changeset{data: %AchievementType{}}

  """
  def change_achievement_type(%AchievementType{} = achievement_type, attrs \\ %{}) do
    AchievementType.changeset(achievement_type, attrs)
  end

  alias DeeperHub.Hub.FeedbackType

  @doc """
  Returns the list of feedback_types.

  ## Examples

      iex> list_feedback_types()
      [%FeedbackType{}, ...]

  """
  def list_feedback_types do
    Repo.all(FeedbackType)
  end

  @doc """
  Gets a single feedback_type.

  Raises `Ecto.NoResultsError` if the Feedback type does not exist.

  ## Examples

      iex> get_feedback_type!(123)
      %FeedbackType{}

      iex> get_feedback_type!(456)
      ** (Ecto.NoResultsError)

  """
  def get_feedback_type!(id), do: Repo.get!(FeedbackType, id)

  @doc """
  Creates a feedback_type.

  ## Examples

      iex> create_feedback_type(%{field: value})
      {:ok, %FeedbackType{}}

      iex> create_feedback_type(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_feedback_type(attrs \\ %{}) do
    %FeedbackType{}
    |> FeedbackType.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a feedback_type.

  ## Examples

      iex> update_feedback_type(feedback_type, %{field: new_value})
      {:ok, %FeedbackType{}}

      iex> update_feedback_type(feedback_type, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_feedback_type(%FeedbackType{} = feedback_type, attrs) do
    feedback_type
    |> FeedbackType.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a feedback_type.

  ## Examples

      iex> delete_feedback_type(feedback_type)
      {:ok, %FeedbackType{}}

      iex> delete_feedback_type(feedback_type)
      {:error, %Ecto.Changeset{}}

  """
  def delete_feedback_type(%FeedbackType{} = feedback_type) do
    Repo.delete(feedback_type)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking feedback_type changes.

  ## Examples

      iex> change_feedback_type(feedback_type)
      %Ecto.Changeset{data: %FeedbackType{}}

  """
  def change_feedback_type(%FeedbackType{} = feedback_type, attrs \\ %{}) do
    FeedbackType.changeset(feedback_type, attrs)
  end

  alias DeeperHub.Hub.Challenge

  @doc """
  Returns the list of challenges.

  ## Examples

      iex> list_challenges()
      [%Challenge{}, ...]

  """
  def list_challenges do
    Repo.all(Challenge)
  end

  @doc """
  Gets a single challenge.

  Raises `Ecto.NoResultsError` if the Challenge does not exist.

  ## Examples

      iex> get_challenge!(123)
      %Challenge{}

      iex> get_challenge!(456)
      ** (Ecto.NoResultsError)

  """
  def get_challenge!(id), do: Repo.get!(Challenge, id)

  @doc """
  Creates a challenge.

  ## Examples

      iex> create_challenge(%{field: value})
      {:ok, %Challenge{}}

      iex> create_challenge(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_challenge(attrs \\ %{}) do
    %Challenge{}
    |> Challenge.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a challenge.

  ## Examples

      iex> update_challenge(challenge, %{field: new_value})
      {:ok, %Challenge{}}

      iex> update_challenge(challenge, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_challenge(%Challenge{} = challenge, attrs) do
    challenge
    |> Challenge.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a challenge.

  ## Examples

      iex> delete_challenge(challenge)
      {:ok, %Challenge{}}

      iex> delete_challenge(challenge)
      {:error, %Ecto.Changeset{}}

  """
  def delete_challenge(%Challenge{} = challenge) do
    Repo.delete(challenge)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking challenge changes.

  ## Examples

      iex> change_challenge(challenge)
      %Ecto.Changeset{data: %Challenge{}}

  """
  def change_challenge(%Challenge{} = challenge, attrs \\ %{}) do
    Challenge.changeset(challenge, attrs)
  end

  alias DeeperHub.Hub.Reward

  @doc """
  Returns the list of rewards.

  ## Examples

      iex> list_rewards()
      [%Reward{}, ...]

  """
  def list_rewards do
    Repo.all(Reward)
  end

  @doc """
  Gets a single reward.

  Raises `Ecto.NoResultsError` if the Reward does not exist.

  ## Examples

      iex> get_reward!(123)
      %Reward{}

      iex> get_reward!(456)
      ** (Ecto.NoResultsError)

  """
  def get_reward!(id), do: Repo.get!(Reward, id)

  @doc """
  Creates a reward.

  ## Examples

      iex> create_reward(%{field: value})
      {:ok, %Reward{}}

      iex> create_reward(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_reward(attrs \\ %{}) do
    %Reward{}
    |> Reward.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a reward.

  ## Examples

      iex> update_reward(reward, %{field: new_value})
      {:ok, %Reward{}}

      iex> update_reward(reward, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_reward(%Reward{} = reward, attrs) do
    reward
    |> Reward.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a reward.

  ## Examples

      iex> delete_reward(reward)
      {:ok, %Reward{}}

      iex> delete_reward(reward)
      {:error, %Ecto.Changeset{}}

  """
  def delete_reward(%Reward{} = reward) do
    Repo.delete(reward)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking reward changes.

  ## Examples

      iex> change_reward(reward)
      %Ecto.Changeset{data: %Reward{}}

  """
  def change_reward(%Reward{} = reward, attrs \\ %{}) do
    Reward.changeset(reward, attrs)
  end

  alias DeeperHub.Hub.Achievement

  @doc """
  Returns the list of achievements.

  ## Examples

      iex> list_achievements()
      [%Achievement{}, ...]

  """
  def list_achievements do
    Repo.all(Achievement)
  end

  @doc """
  Gets a single achievement.

  Raises `Ecto.NoResultsError` if the Achievement does not exist.

  ## Examples

      iex> get_achievement!(123)
      %Achievement{}

      iex> get_achievement!(456)
      ** (Ecto.NoResultsError)

  """
  def get_achievement!(id), do: Repo.get!(Achievement, id)

  @doc """
  Creates a achievement.

  ## Examples

      iex> create_achievement(%{field: value})
      {:ok, %Achievement{}}

      iex> create_achievement(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_achievement(attrs \\ %{}) do
    %Achievement{}
    |> Achievement.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a achievement.

  ## Examples

      iex> update_achievement(achievement, %{field: new_value})
      {:ok, %Achievement{}}

      iex> update_achievement(achievement, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_achievement(%Achievement{} = achievement, attrs) do
    achievement
    |> Achievement.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a achievement.

  ## Examples

      iex> delete_achievement(achievement)
      {:ok, %Achievement{}}

      iex> delete_achievement(achievement)
      {:error, %Ecto.Changeset{}}

  """
  def delete_achievement(%Achievement{} = achievement) do
    Repo.delete(achievement)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking achievement changes.

  ## Examples

      iex> change_achievement(achievement)
      %Ecto.Changeset{data: %Achievement{}}

  """
  def change_achievement(%Achievement{} = achievement, attrs \\ %{}) do
    Achievement.changeset(achievement, attrs)
  end

  alias DeeperHub.Hub.UserFeedback

  @doc """
  Returns the list of user_feedback.

  ## Examples

      iex> list_user_feedback()
      [%UserFeedback{}, ...]

  """
  def list_user_feedback do
    Repo.all(UserFeedback)
  end

  @doc """
  Gets a single user_feedback.

  Raises `Ecto.NoResultsError` if the User feedback does not exist.

  ## Examples

      iex> get_user_feedback!(123)
      %UserFeedback{}

      iex> get_user_feedback!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user_feedback!(id), do: Repo.get!(UserFeedback, id)

  @doc """
  Creates a user_feedback.

  ## Examples

      iex> create_user_feedback(%{field: value})
      {:ok, %UserFeedback{}}

      iex> create_user_feedback(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user_feedback(attrs \\ %{}) do
    %UserFeedback{}
    |> UserFeedback.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user_feedback.

  ## Examples

      iex> update_user_feedback(user_feedback, %{field: new_value})
      {:ok, %UserFeedback{}}

      iex> update_user_feedback(user_feedback, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user_feedback(%UserFeedback{} = user_feedback, attrs) do
    user_feedback
    |> UserFeedback.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user_feedback.

  ## Examples

      iex> delete_user_feedback(user_feedback)
      {:ok, %UserFeedback{}}

      iex> delete_user_feedback(user_feedback)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user_feedback(%UserFeedback{} = user_feedback) do
    Repo.delete(user_feedback)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user_feedback changes.

  ## Examples

      iex> change_user_feedback(user_feedback)
      %Ecto.Changeset{data: %UserFeedback{}}

  """
  def change_user_feedback(%UserFeedback{} = user_feedback, attrs \\ %{}) do
    UserFeedback.changeset(user_feedback, attrs)
  end

  alias DeeperHub.Hub.ServerInvite

  @doc """
  Returns the list of server_invites.

  ## Examples

      iex> list_server_invites()
      [%ServerInvite{}, ...]

  """
  def list_server_invites do
    Repo.all(ServerInvite)
  end

  @doc """
  Gets a single server_invite.

  Raises `Ecto.NoResultsError` if the Server invite does not exist.

  ## Examples

      iex> get_server_invite!(123)
      %ServerInvite{}

      iex> get_server_invite!(456)
      ** (Ecto.NoResultsError)

  """
  def get_server_invite!(id), do: Repo.get!(ServerInvite, id)

  @doc """
  Creates a server_invite.

  ## Examples

      iex> create_server_invite(%{field: value})
      {:ok, %ServerInvite{}}

      iex> create_server_invite(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_server_invite(attrs \\ %{}) do
    %ServerInvite{}
    |> ServerInvite.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a server_invite.

  ## Examples

      iex> update_server_invite(server_invite, %{field: new_value})
      {:ok, %ServerInvite{}}

      iex> update_server_invite(server_invite, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_server_invite(%ServerInvite{} = server_invite, attrs) do
    server_invite
    |> ServerInvite.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a server_invite.

  ## Examples

      iex> delete_server_invite(server_invite)
      {:ok, %ServerInvite{}}

      iex> delete_server_invite(server_invite)
      {:error, %Ecto.Changeset{}}

  """
  def delete_server_invite(%ServerInvite{} = server_invite) do
    Repo.delete(server_invite)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking server_invite changes.

  ## Examples

      iex> change_server_invite(server_invite)
      %Ecto.Changeset{data: %ServerInvite{}}

  """
  def change_server_invite(%ServerInvite{} = server_invite, attrs \\ %{}) do
    ServerInvite.changeset(server_invite, attrs)
  end

  alias DeeperHub.Hub.UserRecommendation

  @doc """
  Returns the list of user_recommendations.

  ## Examples

      iex> list_user_recommendations()
      [%UserRecommendation{}, ...]

  """
  def list_user_recommendations do
    Repo.all(UserRecommendation)
  end

  @doc """
  Gets a single user_recommendation.

  Raises `Ecto.NoResultsError` if the User recommendation does not exist.

  ## Examples

      iex> get_user_recommendation!(123)
      %UserRecommendation{}

      iex> get_user_recommendation!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user_recommendation!(id), do: Repo.get!(UserRecommendation, id)

  @doc """
  Creates a user_recommendation.

  ## Examples

      iex> create_user_recommendation(%{field: value})
      {:ok, %UserRecommendation{}}

      iex> create_user_recommendation(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user_recommendation(attrs \\ %{}) do
    %UserRecommendation{}
    |> UserRecommendation.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user_recommendation.

  ## Examples

      iex> update_user_recommendation(user_recommendation, %{field: new_value})
      {:ok, %UserRecommendation{}}

      iex> update_user_recommendation(user_recommendation, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user_recommendation(%UserRecommendation{} = user_recommendation, attrs) do
    user_recommendation
    |> UserRecommendation.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user_recommendation.

  ## Examples

      iex> delete_user_recommendation(user_recommendation)
      {:ok, %UserRecommendation{}}

      iex> delete_user_recommendation(user_recommendation)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user_recommendation(%UserRecommendation{} = user_recommendation) do
    Repo.delete(user_recommendation)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user_recommendation changes.

  ## Examples

      iex> change_user_recommendation(user_recommendation)
      %Ecto.Changeset{data: %UserRecommendation{}}

  """
  def change_user_recommendation(%UserRecommendation{} = user_recommendation, attrs \\ %{}) do
    UserRecommendation.changeset(user_recommendation, attrs)
  end

  alias DeeperHub.Hub.ServerReputation

  @doc """
  Returns the list of server_reputation.

  ## Examples

      iex> list_server_reputation()
      [%ServerReputation{}, ...]

  """
  def list_server_reputation do
    Repo.all(ServerReputation)
  end

  @doc """
  Gets a single server_reputation.

  Raises `Ecto.NoResultsError` if the Server reputation does not exist.

  ## Examples

      iex> get_server_reputation!(123)
      %ServerReputation{}

      iex> get_server_reputation!(456)
      ** (Ecto.NoResultsError)

  """
  def get_server_reputation!(id), do: Repo.get!(ServerReputation, id)

  @doc """
  Creates a server_reputation.

  ## Examples

      iex> create_server_reputation(%{field: value})
      {:ok, %ServerReputation{}}

      iex> create_server_reputation(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_server_reputation(attrs \\ %{}) do
    %ServerReputation{}
    |> ServerReputation.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a server_reputation.

  ## Examples

      iex> update_server_reputation(server_reputation, %{field: new_value})
      {:ok, %ServerReputation{}}

      iex> update_server_reputation(server_reputation, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_server_reputation(%ServerReputation{} = server_reputation, attrs) do
    server_reputation
    |> ServerReputation.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a server_reputation.

  ## Examples

      iex> delete_server_reputation(server_reputation)
      {:ok, %ServerReputation{}}

      iex> delete_server_reputation(server_reputation)
      {:error, %Ecto.Changeset{}}

  """
  def delete_server_reputation(%ServerReputation{} = server_reputation) do
    Repo.delete(server_reputation)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking server_reputation changes.

  ## Examples

      iex> change_server_reputation(server_reputation)
      %Ecto.Changeset{data: %ServerReputation{}}

  """
  def change_server_reputation(%ServerReputation{} = server_reputation, attrs \\ %{}) do
    ServerReputation.changeset(server_reputation, attrs)
  end

  alias DeeperHub.Hub.Report

  @doc """
  Returns the list of reports.

  ## Examples

      iex> list_reports()
      [%Report{}, ...]

  """
  def list_reports do
    Repo.all(Report)
  end

  @doc """
  Gets a single report.

  Raises `Ecto.NoResultsError` if the Report does not exist.

  ## Examples

      iex> get_report!(123)
      %Report{}

      iex> get_report!(456)
      ** (Ecto.NoResultsError)

  """
  def get_report!(id), do: Repo.get!(Report, id)

  @doc """
  Creates a report.

  ## Examples

      iex> create_report(%{field: value})
      {:ok, %Report{}}

      iex> create_report(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_report(attrs \\ %{}) do
    %Report{}
    |> Report.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a report.

  ## Examples

      iex> update_report(report, %{field: new_value})
      {:ok, %Report{}}

      iex> update_report(report, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_report(%Report{} = report, attrs) do
    report
    |> Report.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a report.

  ## Examples

      iex> delete_report(report)
      {:ok, %Report{}}

      iex> delete_report(report)
      {:error, %Ecto.Changeset{}}

  """
  def delete_report(%Report{} = report) do
    Repo.delete(report)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking report changes.

  ## Examples

      iex> change_report(report)
      %Ecto.Changeset{data: %Report{}}

  """
  def change_report(%Report{} = report, attrs \\ %{}) do
    Report.changeset(report, attrs)
  end

  alias DeeperHub.Hub.ServerAdvertisement

  @doc """
  Returns the list of advertisements.

  ## Examples

      iex> list_advertisements()
      [%ServerAdvertisement{}, ...]

  """
  def list_advertisements do
    Repo.all(ServerAdvertisement)
  end

  @doc """
  Gets a single server_advertisement.

  Raises `Ecto.NoResultsError` if the Server advertisement does not exist.

  ## Examples

      iex> get_server_advertisement!(123)
      %ServerAdvertisement{}

      iex> get_server_advertisement!(456)
      ** (Ecto.NoResultsError)

  """
  def get_server_advertisement!(id), do: Repo.get!(ServerAdvertisement, id)

  @doc """
  Creates a server_advertisement.

  ## Examples

      iex> create_server_advertisement(%{field: value})
      {:ok, %ServerAdvertisement{}}

      iex> create_server_advertisement(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_server_advertisement(attrs \\ %{}) do
    %ServerAdvertisement{}
    |> ServerAdvertisement.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a server_advertisement.

  ## Examples

      iex> update_server_advertisement(server_advertisement, %{field: new_value})
      {:ok, %ServerAdvertisement{}}

      iex> update_server_advertisement(server_advertisement, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_server_advertisement(%ServerAdvertisement{} = server_advertisement, attrs) do
    server_advertisement
    |> ServerAdvertisement.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a server_advertisement.

  ## Examples

      iex> delete_server_advertisement(server_advertisement)
      {:ok, %ServerAdvertisement{}}

      iex> delete_server_advertisement(server_advertisement)
      {:error, %Ecto.Changeset{}}

  """
  def delete_server_advertisement(%ServerAdvertisement{} = server_advertisement) do
    Repo.delete(server_advertisement)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking server_advertisement changes.

  ## Examples

      iex> change_server_advertisement(server_advertisement)
      %Ecto.Changeset{data: %ServerAdvertisement{}}

  """
  def change_server_advertisement(%ServerAdvertisement{} = server_advertisement, attrs \\ %{}) do
    ServerAdvertisement.changeset(server_advertisement, attrs)
  end

  alias DeeperHub.Hub.SupportTicket

  @doc """
  Returns the list of support_tickets.

  ## Examples

      iex> list_support_tickets()
      [%SupportTicket{}, ...]

  """
  def list_support_tickets do
    Repo.all(SupportTicket)
  end

  @doc """
  Gets a single support_ticket.

  Raises `Ecto.NoResultsError` if the Support ticket does not exist.

  ## Examples

      iex> get_support_ticket!(123)
      %SupportTicket{}

      iex> get_support_ticket!(456)
      ** (Ecto.NoResultsError)

  """
  def get_support_ticket!(id), do: Repo.get!(SupportTicket, id)

  @doc """
  Creates a support_ticket.

  ## Examples

      iex> create_support_ticket(%{field: value})
      {:ok, %SupportTicket{}}

      iex> create_support_ticket(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_support_ticket(attrs \\ %{}) do
    %SupportTicket{}
    |> SupportTicket.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a support_ticket.

  ## Examples

      iex> update_support_ticket(support_ticket, %{field: new_value})
      {:ok, %SupportTicket{}}

      iex> update_support_ticket(support_ticket, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_support_ticket(%SupportTicket{} = support_ticket, attrs) do
    support_ticket
    |> SupportTicket.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a support_ticket.

  ## Examples

      iex> delete_support_ticket(support_ticket)
      {:ok, %SupportTicket{}}

      iex> delete_support_ticket(support_ticket)
      {:error, %Ecto.Changeset{}}

  """
  def delete_support_ticket(%SupportTicket{} = support_ticket) do
    Repo.delete(support_ticket)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking support_ticket changes.

  ## Examples

      iex> change_support_ticket(support_ticket)
      %Ecto.Changeset{data: %SupportTicket{}}

  """
  def change_support_ticket(%SupportTicket{} = support_ticket, attrs \\ %{}) do
    SupportTicket.changeset(support_ticket, attrs)
  end

  alias DeeperHub.Hub.ServerReview

  @doc """
  Returns the list of reviews.

  ## Examples

      iex> list_reviews()
      [%ServerReview{}, ...]

  """
  def list_reviews do
    Repo.all(ServerReview)
  end

  @doc """
  Gets a single server_review.

  Raises `Ecto.NoResultsError` if the Server review does not exist.

  ## Examples

      iex> get_server_review!(123)
      %ServerReview{}

      iex> get_server_review!(456)
      ** (Ecto.NoResultsError)

  """
  def get_server_review!(id), do: Repo.get!(ServerReview, id)

  @doc """
  Creates a server_review.

  ## Examples

      iex> create_server_review(%{field: value})
      {:ok, %ServerReview{}}

      iex> create_server_review(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_server_review(attrs \\ %{}) do
    %ServerReview{}
    |> ServerReview.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a server_review.

  ## Examples

      iex> update_server_review(server_review, %{field: new_value})
      {:ok, %ServerReview{}}

      iex> update_server_review(server_review, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_server_review(%ServerReview{} = server_review, attrs) do
    server_review
    |> ServerReview.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a server_review.

  ## Examples

      iex> delete_server_review(server_review)
      {:ok, %ServerReview{}}

      iex> delete_server_review(server_review)
      {:error, %Ecto.Changeset{}}

  """
  def delete_server_review(%ServerReview{} = server_review) do
    Repo.delete(server_review)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking server_review changes.

  ## Examples

      iex> change_server_review(server_review)
      %Ecto.Changeset{data: %ServerReview{}}

  """
  def change_server_review(%ServerReview{} = server_review, attrs \\ %{}) do
    ServerReview.changeset(server_review, attrs)
  end

  alias DeeperHub.Hub.Rating

  @doc """
  Returns the list of ratings.

  ## Examples

      iex> list_ratings()
      [%Rating{}, ...]

  """
  def list_ratings do
    Repo.all(Rating)
  end

  @doc """
  Gets a single rating.

  Raises `Ecto.NoResultsError` if the Rating does not exist.

  ## Examples

      iex> get_rating!(123)
      %Rating{}

      iex> get_rating!(456)
      ** (Ecto.NoResultsError)

  """
  def get_rating!(id), do: Repo.get!(Rating, id)

  @doc """
  Creates a rating.

  ## Examples

      iex> create_rating(%{field: value})
      {:ok, %Rating{}}

      iex> create_rating(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_rating(attrs \\ %{}) do
    %Rating{}
    |> Rating.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a rating.

  ## Examples

      iex> update_rating(rating, %{field: new_value})
      {:ok, %Rating{}}

      iex> update_rating(rating, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_rating(%Rating{} = rating, attrs) do
    rating
    |> Rating.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a rating.

  ## Examples

      iex> delete_rating(rating)
      {:ok, %Rating{}}

      iex> delete_rating(rating)
      {:error, %Ecto.Changeset{}}

  """
  def delete_rating(%Rating{} = rating) do
    Repo.delete(rating)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking rating changes.

  ## Examples

      iex> change_rating(rating)
      %Ecto.Changeset{data: %Rating{}}

  """
  def change_rating(%Rating{} = rating, attrs \\ %{}) do
    Rating.changeset(rating, attrs)
  end

  alias DeeperHub.Hub.ServerTag

  @doc """
  Returns the list of server_tags.

  ## Examples

      iex> list_server_tags()
      [%ServerTag{}, ...]

  """
  def list_server_tags do
    Repo.all(ServerTag)
  end

  @doc """
  Gets a single server_tag.

  Raises `Ecto.NoResultsError` if the Server tag does not exist.

  ## Examples

      iex> get_server_tag!(123)
      %ServerTag{}

      iex> get_server_tag!(456)
      ** (Ecto.NoResultsError)

  """
  def get_server_tag!(id), do: Repo.get!(ServerTag, id)

  @doc """
  Creates a server_tag.

  ## Examples

      iex> create_server_tag(%{field: value})
      {:ok, %ServerTag{}}

      iex> create_server_tag(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_server_tag(attrs \\ %{}) do
    %ServerTag{}
    |> ServerTag.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a server_tag.

  ## Examples

      iex> update_server_tag(server_tag, %{field: new_value})
      {:ok, %ServerTag{}}

      iex> update_server_tag(server_tag, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_server_tag(%ServerTag{} = server_tag, attrs) do
    server_tag
    |> ServerTag.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a server_tag.

  ## Examples

      iex> delete_server_tag(server_tag)
      {:ok, %ServerTag{}}

      iex> delete_server_tag(server_tag)
      {:error, %Ecto.Changeset{}}

  """
  def delete_server_tag(%ServerTag{} = server_tag) do
    Repo.delete(server_tag)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking server_tag changes.

  ## Examples

      iex> change_server_tag(server_tag)
      %Ecto.Changeset{data: %ServerTag{}}

  """
  def change_server_tag(%ServerTag{} = server_tag, attrs \\ %{}) do
    ServerTag.changeset(server_tag, attrs)
  end

  alias DeeperHub.Hub.ServerEvent

  @doc """
  Returns the list of events.

  ## Examples

      iex> list_events()
      [%ServerEvent{}, ...]

  """
  def list_events do
    Repo.all(ServerEvent)
  end

  @doc """
  Gets a single server_event.

  Raises `Ecto.NoResultsError` if the Server event does not exist.

  ## Examples

      iex> get_server_event!(123)
      %ServerEvent{}

      iex> get_server_event!(456)
      ** (Ecto.NoResultsError)

  """
  def get_server_event!(id), do: Repo.get!(ServerEvent, id)

  @doc """
  Creates a server_event.

  ## Examples

      iex> create_server_event(%{field: value})
      {:ok, %ServerEvent{}}

      iex> create_server_event(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_server_event(attrs \\ %{}) do
    %ServerEvent{}
    |> ServerEvent.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a server_event.

  ## Examples

      iex> update_server_event(server_event, %{field: new_value})
      {:ok, %ServerEvent{}}

      iex> update_server_event(server_event, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_server_event(%ServerEvent{} = server_event, attrs) do
    server_event
    |> ServerEvent.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a server_event.

  ## Examples

      iex> delete_server_event(server_event)
      {:ok, %ServerEvent{}}

      iex> delete_server_event(server_event)
      {:error, %Ecto.Changeset{}}

  """
  def delete_server_event(%ServerEvent{} = server_event) do
    Repo.delete(server_event)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking server_event changes.

  ## Examples

      iex> change_server_event(server_event)
      %Ecto.Changeset{data: %ServerEvent{}}

  """
  def change_server_event(%ServerEvent{} = server_event, attrs \\ %{}) do
    ServerEvent.changeset(server_event, attrs)
  end

  alias DeeperHub.Hub.ServerUpdateMessage

  @doc """
  Returns the list of server_update_messages.

  ## Examples

      iex> list_server_update_messages()
      [%ServerUpdateMessage{}, ...]

  """
  def list_server_update_messages do
    Repo.all(ServerUpdateMessage)
  end

  @doc """
  Gets a single server_update_message.

  Raises `Ecto.NoResultsError` if the Server update message does not exist.

  ## Examples

      iex> get_server_update_message!(123)
      %ServerUpdateMessage{}

      iex> get_server_update_message!(456)
      ** (Ecto.NoResultsError)

  """
  def get_server_update_message!(id), do: Repo.get!(ServerUpdateMessage, id)

  @doc """
  Creates a server_update_message.

  ## Examples

      iex> create_server_update_message(%{field: value})
      {:ok, %ServerUpdateMessage{}}

      iex> create_server_update_message(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_server_update_message(attrs \\ %{}) do
    %ServerUpdateMessage{}
    |> ServerUpdateMessage.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a server_update_message.

  ## Examples

      iex> update_server_update_message(server_update_message, %{field: new_value})
      {:ok, %ServerUpdateMessage{}}

      iex> update_server_update_message(server_update_message, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_server_update_message(%ServerUpdateMessage{} = server_update_message, attrs) do
    server_update_message
    |> ServerUpdateMessage.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a server_update_message.

  ## Examples

      iex> delete_server_update_message(server_update_message)
      {:ok, %ServerUpdateMessage{}}

      iex> delete_server_update_message(server_update_message)
      {:error, %Ecto.Changeset{}}

  """
  def delete_server_update_message(%ServerUpdateMessage{} = server_update_message) do
    Repo.delete(server_update_message)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking server_update_message changes.

  ## Examples

      iex> change_server_update_message(server_update_message)
      %Ecto.Changeset{data: %ServerUpdateMessage{}}

  """
  def change_server_update_message(%ServerUpdateMessage{} = server_update_message, attrs \\ %{}) do
    ServerUpdateMessage.changeset(server_update_message, attrs)
  end
end

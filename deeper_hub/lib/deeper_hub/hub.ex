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
end

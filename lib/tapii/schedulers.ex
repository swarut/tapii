defmodule Tapii.Schedulers do
  @moduledoc """
  The Schedulers context.
  """

  import Ecto.Query, warn: false
  alias Tapii.Repo

  alias Tapii.Schedulers.Scheduler

  @doc """
  Returns the list of schedulers.

  ## Examples

      iex> list_schedulers()
      [%Scheduler{}, ...]

  """
  def list_schedulers do
    Repo.all(Scheduler)
  end

  @doc """
  Gets a single scheduler.

  Raises `Ecto.NoResultsError` if the Scheduler does not exist.

  ## Examples

      iex> get_scheduler!(123)
      %Scheduler{}

      iex> get_scheduler!(456)
      ** (Ecto.NoResultsError)

  """
  def get_scheduler!(id), do: Repo.get!(Scheduler, id)

  @doc """
  Creates a scheduler.

  ## Examples

      iex> create_scheduler(%{field: value})
      {:ok, %Scheduler{}}

      iex> create_scheduler(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_scheduler(attrs \\ %{}) do
    %Scheduler{}
    |> Scheduler.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a scheduler.

  ## Examples

      iex> update_scheduler(scheduler, %{field: new_value})
      {:ok, %Scheduler{}}

      iex> update_scheduler(scheduler, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_scheduler(%Scheduler{} = scheduler, attrs) do
    scheduler
    |> Scheduler.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a scheduler.

  ## Examples

      iex> delete_scheduler(scheduler)
      {:ok, %Scheduler{}}

      iex> delete_scheduler(scheduler)
      {:error, %Ecto.Changeset{}}

  """
  def delete_scheduler(%Scheduler{} = scheduler) do
    Repo.delete(scheduler)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking scheduler changes.

  ## Examples

      iex> change_scheduler(scheduler)
      %Ecto.Changeset{data: %Scheduler{}}

  """
  def change_scheduler(%Scheduler{} = scheduler, attrs \\ %{}) do
    Scheduler.changeset(scheduler, attrs)
  end

  alias Tapii.Schedulers.SchedulerSubstitution

  @doc """
  Returns the list of scheduler_substitutions.

  ## Examples

      iex> list_scheduler_substitutions()
      [%SchedulerSubstitution{}, ...]

  """
  def list_scheduler_substitutions do
    Repo.all(SchedulerSubstitution)
  end

  @doc """
  Gets a single scheduler_substitution.

  Raises `Ecto.NoResultsError` if the Scheduler substitution does not exist.

  ## Examples

      iex> get_scheduler_substitution!(123)
      %SchedulerSubstitution{}

      iex> get_scheduler_substitution!(456)
      ** (Ecto.NoResultsError)

  """
  def get_scheduler_substitution!(id), do: Repo.get!(SchedulerSubstitution, id)

  @doc """
  Creates a scheduler_substitution.

  ## Examples

      iex> create_scheduler_substitution(%{field: value})
      {:ok, %SchedulerSubstitution{}}

      iex> create_scheduler_substitution(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_scheduler_substitution(attrs \\ %{}) do
    %SchedulerSubstitution{}
    |> SchedulerSubstitution.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a scheduler_substitution.

  ## Examples

      iex> update_scheduler_substitution(scheduler_substitution, %{field: new_value})
      {:ok, %SchedulerSubstitution{}}

      iex> update_scheduler_substitution(scheduler_substitution, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_scheduler_substitution(%SchedulerSubstitution{} = scheduler_substitution, attrs) do
    scheduler_substitution
    |> SchedulerSubstitution.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a scheduler_substitution.

  ## Examples

      iex> delete_scheduler_substitution(scheduler_substitution)
      {:ok, %SchedulerSubstitution{}}

      iex> delete_scheduler_substitution(scheduler_substitution)
      {:error, %Ecto.Changeset{}}

  """
  def delete_scheduler_substitution(%SchedulerSubstitution{} = scheduler_substitution) do
    Repo.delete(scheduler_substitution)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking scheduler_substitution changes.

  ## Examples

      iex> change_scheduler_substitution(scheduler_substitution)
      %Ecto.Changeset{data: %SchedulerSubstitution{}}

  """
  def change_scheduler_substitution(%SchedulerSubstitution{} = scheduler_substitution, attrs \\ %{}) do
    SchedulerSubstitution.changeset(scheduler_substitution, attrs)
  end

  alias Tapii.Schedulers.History

  @doc """
  Returns the list of histories.

  ## Examples

      iex> list_histories()
      [%History{}, ...]

  """
  def list_histories do
    Repo.all(History)
  end

  @doc """
  Gets a single history.

  Raises `Ecto.NoResultsError` if the History does not exist.

  ## Examples

      iex> get_history!(123)
      %History{}

      iex> get_history!(456)
      ** (Ecto.NoResultsError)

  """
  def get_history!(id), do: Repo.get!(History, id)

  @doc """
  Creates a history.

  ## Examples

      iex> create_history(%{field: value})
      {:ok, %History{}}

      iex> create_history(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_history(attrs \\ %{}) do
    %History{}
    |> History.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a history.

  ## Examples

      iex> update_history(history, %{field: new_value})
      {:ok, %History{}}

      iex> update_history(history, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_history(%History{} = history, attrs) do
    history
    |> History.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a history.

  ## Examples

      iex> delete_history(history)
      {:ok, %History{}}

      iex> delete_history(history)
      {:error, %Ecto.Changeset{}}

  """
  def delete_history(%History{} = history) do
    Repo.delete(history)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking history changes.

  ## Examples

      iex> change_history(history)
      %Ecto.Changeset{data: %History{}}

  """
  def change_history(%History{} = history, attrs \\ %{}) do
    History.changeset(history, attrs)
  end
end

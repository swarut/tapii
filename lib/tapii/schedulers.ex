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
end

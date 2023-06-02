defmodule Tapii.SchedulersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Tapii.Schedulers` context.
  """

  @doc """
  Generate a scheduler.
  """
  def scheduler_fixture(attrs \\ %{}) do
    {:ok, scheduler} =
      attrs
      |> Enum.into(%{
        active: true,
        occurence: 42,
        time: ~T[14:00:00]
      })
      |> Tapii.Schedulers.create_scheduler()

    scheduler
  end

  @doc """
  Generate a scheduler_substitution.
  """
  def scheduler_substitution_fixture(attrs \\ %{}) do
    {:ok, scheduler_substitution} =
      attrs
      |> Enum.into(%{
        key: "some key",
        value: "some value"
      })
      |> Tapii.Schedulers.create_scheduler_substitution()

    scheduler_substitution
  end
end

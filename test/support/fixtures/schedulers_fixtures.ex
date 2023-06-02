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
end

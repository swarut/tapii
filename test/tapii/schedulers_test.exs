defmodule Tapii.SchedulersTest do
  use Tapii.DataCase

  alias Tapii.Schedulers

  describe "schedulers" do
    alias Tapii.Schedulers.Scheduler

    import Tapii.SchedulersFixtures

    @invalid_attrs %{active: nil, occurence: nil, time: nil}

    test "list_schedulers/0 returns all schedulers" do
      scheduler = scheduler_fixture()
      assert Schedulers.list_schedulers() == [scheduler]
    end

    test "get_scheduler!/1 returns the scheduler with given id" do
      scheduler = scheduler_fixture()
      assert Schedulers.get_scheduler!(scheduler.id) == scheduler
    end

    test "create_scheduler/1 with valid data creates a scheduler" do
      valid_attrs = %{active: true, occurence: 42, time: ~T[14:00:00]}

      assert {:ok, %Scheduler{} = scheduler} = Schedulers.create_scheduler(valid_attrs)
      assert scheduler.active == true
      assert scheduler.occurence == 42
      assert scheduler.time == ~T[14:00:00]
    end

    test "create_scheduler/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Schedulers.create_scheduler(@invalid_attrs)
    end

    test "update_scheduler/2 with valid data updates the scheduler" do
      scheduler = scheduler_fixture()
      update_attrs = %{active: false, occurence: 43, time: ~T[15:01:01]}

      assert {:ok, %Scheduler{} = scheduler} = Schedulers.update_scheduler(scheduler, update_attrs)
      assert scheduler.active == false
      assert scheduler.occurence == 43
      assert scheduler.time == ~T[15:01:01]
    end

    test "update_scheduler/2 with invalid data returns error changeset" do
      scheduler = scheduler_fixture()
      assert {:error, %Ecto.Changeset{}} = Schedulers.update_scheduler(scheduler, @invalid_attrs)
      assert scheduler == Schedulers.get_scheduler!(scheduler.id)
    end

    test "delete_scheduler/1 deletes the scheduler" do
      scheduler = scheduler_fixture()
      assert {:ok, %Scheduler{}} = Schedulers.delete_scheduler(scheduler)
      assert_raise Ecto.NoResultsError, fn -> Schedulers.get_scheduler!(scheduler.id) end
    end

    test "change_scheduler/1 returns a scheduler changeset" do
      scheduler = scheduler_fixture()
      assert %Ecto.Changeset{} = Schedulers.change_scheduler(scheduler)
    end
  end

  describe "scheduler_substitutions" do
    alias Tapii.Schedulers.SchedulerSubstitution

    import Tapii.SchedulersFixtures

    @invalid_attrs %{key: nil, value: nil}

    test "list_scheduler_substitutions/0 returns all scheduler_substitutions" do
      scheduler_substitution = scheduler_substitution_fixture()
      assert Schedulers.list_scheduler_substitutions() == [scheduler_substitution]
    end

    test "get_scheduler_substitution!/1 returns the scheduler_substitution with given id" do
      scheduler_substitution = scheduler_substitution_fixture()
      assert Schedulers.get_scheduler_substitution!(scheduler_substitution.id) == scheduler_substitution
    end

    test "create_scheduler_substitution/1 with valid data creates a scheduler_substitution" do
      valid_attrs = %{key: "some key", value: "some value"}

      assert {:ok, %SchedulerSubstitution{} = scheduler_substitution} = Schedulers.create_scheduler_substitution(valid_attrs)
      assert scheduler_substitution.key == "some key"
      assert scheduler_substitution.value == "some value"
    end

    test "create_scheduler_substitution/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Schedulers.create_scheduler_substitution(@invalid_attrs)
    end

    test "update_scheduler_substitution/2 with valid data updates the scheduler_substitution" do
      scheduler_substitution = scheduler_substitution_fixture()
      update_attrs = %{key: "some updated key", value: "some updated value"}

      assert {:ok, %SchedulerSubstitution{} = scheduler_substitution} = Schedulers.update_scheduler_substitution(scheduler_substitution, update_attrs)
      assert scheduler_substitution.key == "some updated key"
      assert scheduler_substitution.value == "some updated value"
    end

    test "update_scheduler_substitution/2 with invalid data returns error changeset" do
      scheduler_substitution = scheduler_substitution_fixture()
      assert {:error, %Ecto.Changeset{}} = Schedulers.update_scheduler_substitution(scheduler_substitution, @invalid_attrs)
      assert scheduler_substitution == Schedulers.get_scheduler_substitution!(scheduler_substitution.id)
    end

    test "delete_scheduler_substitution/1 deletes the scheduler_substitution" do
      scheduler_substitution = scheduler_substitution_fixture()
      assert {:ok, %SchedulerSubstitution{}} = Schedulers.delete_scheduler_substitution(scheduler_substitution)
      assert_raise Ecto.NoResultsError, fn -> Schedulers.get_scheduler_substitution!(scheduler_substitution.id) end
    end

    test "change_scheduler_substitution/1 returns a scheduler_substitution changeset" do
      scheduler_substitution = scheduler_substitution_fixture()
      assert %Ecto.Changeset{} = Schedulers.change_scheduler_substitution(scheduler_substitution)
    end
  end
end

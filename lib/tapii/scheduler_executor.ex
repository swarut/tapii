defmodule Tapii.ScheduleExecutor do
  use GenServer
  require Logger

  defstruct [:interval_sec, :scheduler_id]

  # Server
  @impl true
  def init({user_id, scheduler_id}) do
    user = Tapii.Accounts.get_user!(user_id)
    token = Tapii.Accounts.generate_sumo_auth_token(user)
    state = %{interval_sec: 2, scheduler_id: scheduler_id, auth_token: token}

    state
    |> schedule_work()
    |> then(&{:ok, &1})
  end

  def schedule_work(state) do
    IO.puts("ScheduleExecutor is scheduling job in 10 seconds")
    Process.send_after(self(), :perform_work, :timer.seconds(state.interval_sec))
    state
  end
  def perform_work(state) do
    IO.puts("ScheduleExecutor is working!")
    # random_number = Enum.random((1..100) |> Enum.to_list)
    Tapii.SearchJobRequest.start_link(state.auth_token, state.scheduler_id)
    state
  end

  @impl true
  def handle_call(:pop, _from, state) do
    [to_caller | new_state] = state.items
    {:reply, to_caller, %{state | items: new_state}}
  end
  def handle_call(:show, _from, state) do
    IO.puts("Stack of ScheduleExecutor")
    IO.inspect(state)
    {:reply, state, state}
  end

  @impl true
  def handle_cast({:push, element}, state) do
    new_state = [element | state]
    {:noreply, %{state | items: new_state}}
  end

  @impl true
  def handle_info(:perform_work, state) do
    IO.puts("ScheduleExecutor's handle_info")
    state
    # |> schedule_work
    |> perform_work
    |> then(&{:noreply, &1})
  end

  # Client
  # def start_link(default) when is_binary(default) do
  #   GenServer.start_link(__MODULE__, default, name: ScheduleExecutor)
  # end
  def start_link(scheduler_id) do
    GenServer.start_link(__MODULE__, scheduler_id, name: ScheduleExecutor)
  end
end

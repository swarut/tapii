defmodule Tapii.Penguin do
  use GenServer
  require Logger

  defstruct [:interval_sec, :items]

  # Server
  @impl true
  def init(elements) do
    items = String.split(elements, ",", trim: true)
    state = %{interval_sec: 10, items: items}

    state
    |> schedule_work()
    |> then(&{:ok, &1})
  end

  def schedule_work(state) do
    IO.puts("Penguin is scheduling job in 10 seconds")
    Process.send_after(self(), :perform_work, :timer.seconds(state.interval_sec))
    state
  end
  def perform_work(state) do
    IO.puts("Penguin is working!")
    state
  end

  @impl true
  def handle_call(:pop, _from, state) do
    [to_caller | new_state] = state.items
    {:reply, to_caller, %{state | items: new_state}}
  end
  def handle_call(:show, _from, state) do
    IO.puts("Stack of Penguin")
    IO.inspect(state)
    {:reply, state, state}
  end
  def handle_call(:showx, _from, state) do
    IO.puts("Stack of Penguin - this will fail")
    IO.inspect(state)
    # {:reply, state, state}
  end

  @impl true
  def handle_cast({:push, element}, state) do
    new_state = [element | state]
    {:noreply, %{state | items: new_state}}
  end

  @impl true
  def handle_info(:perform_work, state) do
    IO.puts("Penguin's handle_info")
    state
    |> schedule_work
    |> perform_work
    |> then(&{:noreply, &1})
  end

  # Client
  def start_link(default) when is_binary(default) do
    GenServer.start_link(__MODULE__, default, name: Penguin)
  end
end

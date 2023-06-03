defmodule Tapii.Penguin do
  use GenServer
  require Logger

  # Server
  @impl true
  def init(elements) do
    initial_state = String.split(elements, ",", trim: true)
    {:ok, initial_state}
  end

  @impl true
  def handle_call(:pop, _from, state) do
    [to_caller | new_state] = state
    {:reply, to_caller, new_state}
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
    {:noreply, new_state}
  end

  # Client
  def start_link(default) when is_binary(default) do
    GenServer.start_link(__MODULE__, default, name: Penguin)
  end

  def push(pid, element) do
    GenServer.cast(pid, {:push, element})
  end

  def pop(pid) do
    GenServer.call(pid, :pop)
  end
end

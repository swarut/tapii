defmodule Tapii.Pon2 do

  use GenServer

  def init(init_arg) do
    {:ok, init_arg}
  end

  def hello do
    IO.puts "Hello"
  end

  def handle_info(:hello, state) do

    IO.puts("Handle info #{state}")
    {:noreply, state}
  end

  def start_link(default) when is_binary(default) do
    GenServer.start_link(__MODULE__, default, name: Pon2)
  end

  def notify_parent(msg), do: send(self(), {__MODULE__, msg})
end

defmodule Tapii.Pon do
  use Task
  require Logger

  def start_link(arg) do
    Task.start_link(__MODULE__, :run, [arg])
  end

  def run(_arg) do
    Logger.info("Pon pon pon yayhhhaa")
    Process.sleep(10000)
    Logger.info("Pon pon pon byeeee")
  end
end

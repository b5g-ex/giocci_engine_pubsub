defmodule TaskDo do
  use GenServer

  def load_task do
    data = GenServer.call(TaskQueue,:get_newtask)
  end

  def start_timemeasurment do
    CountRT.count_start()
  end


  def finish_timemeasurment do
    CountRT.count_finish()
  end

  def main do
    client_data=load_task()
    start_timemeasurment()
    Process.sleep(1000)
    finish_timemeasurment()

  end
end

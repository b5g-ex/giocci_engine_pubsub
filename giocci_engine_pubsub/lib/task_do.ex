defmodule TaskDo do
  use GenServer

  def load_task do
    data = GenServer.call(TaskQueue,:get_newtask)
  end

  def start_timemeasurment do
    start_clo =  DateTime.utc_now()
  end


  def finish_timemeasurment do
    finish_clo =  DateTime.utc_now()
  end

  def main do
    client_data=load_task()


    start_clock = start_timemeasurment()
    Process.sleep(1000)
    finish_clock = finish_timemeasurment()
    processing_time = DateTime.diff(finish_clock, start_clock, :microsecond)
    # processing_time = 10000000
    GenServer.cast(CountRT, {:send_RT2,processing_time})

  end
end

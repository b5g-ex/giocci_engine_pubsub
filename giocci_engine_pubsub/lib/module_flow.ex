defmodule ModuleFlow do

  def start_timemeasurment do
    start_clo =  DateTime.utc_now()
  end


  def finish_timemeasurment do
    finish_clo =  DateTime.utc_now()
  end


  # def  get_task(dummy,dummy2) do
  #   module = dummy
  #   data = dummy2
  #   spawn(do_task(module,data))
  #   Process.sleep(10000)
  #   spawn(get_task(dummy,dummy2))

  # end
  def  get_task() do

    data = GenServer.call(TaskQueue,:get_newtask)

    spawn(do_task(data))
    Process.sleep(10000)
    spawn(get_task())

  end



  def do_task(data) do
    name = "test"
    start_clock = start_timemeasurment()
    CountRT.send_startRT(start_clock,name)
    Process.sleep(1000)
    finish_clock = finish_timemeasurment()
    CountRT.send_finishRT(finish_clock,name)
    # processing_time = DateTime.diff(finish_clock, start_clock, :microsecond)
    # GenServer.cast(CountRT, {:send_RT,processing_time})



  end
end

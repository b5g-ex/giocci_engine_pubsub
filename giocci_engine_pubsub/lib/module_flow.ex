defmodule ModuleFlow do



  def  get_task(dummy,dummy2) do
    module = dummy
    data = dummy2

  end


  def do_task(climodule,clidata) do
    module = climodule
    data = clidata
    start_clock = start_timemeasurment()
    Process.sleep(1000)
    finish_clock = finish_timemeasurment()
    processing_time = DateTime.diff(finish_clock, start_clock, :microsecond)
    # processing_time = 10000000
    # GenServer.cast(CountRT, {:send_RT,processing_time})
    CountRT.send_RT()


  end
end

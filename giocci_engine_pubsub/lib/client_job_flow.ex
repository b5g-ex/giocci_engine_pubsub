defmodule ClientJobFlow do
  # def start_timemeasurment do
  #   start_clo = DateTime.utc_now()
  # end

  # def finish_timemeasurment do
  #   finish_clo = DateTime.utc_now()
  # end

  def load_task(job) do
    [mod_encoded, flow, data] =job
    module = decode_module(mod_encoded)
    {name, bin, path}=Base.decode64!(mod_encoded)|>:erlang.binary_to_term()
    :code.load_binary(name, path, bin)

    spawn(execute_job(flow,data))
  end
  def decode_module(module) do

    {name, bin, path}=:code.load_binary(module)

  end

  # def read_module_func(module_or_func) do
  #   module_or_func
  # end

  # defp flow(dummy) do
  #   IO.put("dummy function")
  # end

  def execute_job(flow,data) do
    name = "test"
    IO.inspect(flow)
    start_clock =DateTime.utc_now()
    # [module | left_job] =job
    # [flow |data ] = left_job
    # read_module_func(module)
    # read_module_func(flow)
    # data = flow(data)
    Enum.map(data, flow)



    CountRT.send_startRT(start_clock, name)
    Process.sleep(1000)
    finish_clock = DateTime.utc_now()
    CountRT.send_finishRT(finish_clock, name)
    # processing_time = DateTime.diff(finish_clock, start_clock, :microsecond)
    # GenServer.cast(CountRT, {:send_RT,processing_time})
  end
end

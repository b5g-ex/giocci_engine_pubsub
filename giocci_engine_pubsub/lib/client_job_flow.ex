defmodule ClientJobFlow do
  # def start_timemeasurment do
  #   start_clo = DateTime.utc_now()
  # end

  # def finish_timemeasurment do
  #   finish_clo = DateTime.utc_now()
  # end

  def load_task([mod_encoded, data]) do
    # [mod_encoded, flow, data]
    name = decode_and_import_module(mod_encoded)
    # IO.inspect([module,flow,data])
    # {name, bin, path}=Base.decode64!(mod_encoded)|>:erlang.binary_to_term()
    # :code.load_binary(name, path, bin)

    # execute_job(flow,data)
    execute_job(data,name)
  end
  def decode_and_import_module(module) do

    {name, bin, path}=Base.decode64!(module)|>:erlang.binary_to_term

    :code.load_binary(name, path, bin)
    module_name =name

  end

  # def read_module_func(module_or_func) do
  #   module_or_func
  # end

  # defp flow(dummy) do
  #   IO.put("dummy function")
  # end

  def execute_job(data,name) do
    # name = "test"
    # IO.inspect(flow)
    start_clock =DateTime.utc_now()
    # [module | left_job] =job
    # [flow |data ] = left_job
    # read_module_func(module)
    # read_module_func(flow)
    # data = flow(data)


    # IO.inspect(data)
    # IO.inspect(flow)

    # CountRT.send_startRT(start_clock, name)
    answer = Enum.map(data, &name.flow/1)
    IO.inspect(answer)
    finish_clock = DateTime.utc_now()
    processing_time = DateTime.diff(finish_clock, start_clock, :microsecond)
    GenServer.cast(CountRT, {:send_RT, processing_time})
    GiocciEnginePubsub.publishcl(answer)
    # CountRT.send_finishRT(finish_clock, name)
    # processing_time = DateTime.diff(finish_clock, start_clock, :microsecond)
    # GenServer.cast(CountRT, {:send_RT,processing_time})
  end
end

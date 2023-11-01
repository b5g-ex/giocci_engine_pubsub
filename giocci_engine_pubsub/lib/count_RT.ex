defmodule CountRT do
  use GenServer

  def count_start do
    start = DateTime.utc_now()
    GenServer.cast(CountRT,{:reserve_start_utc,start_time})
  end

  def count_finish do
    finish = DateTime.utc_now()
    start = GenServer.call(CounTRT,:get_start_utc)
    processing_time = 100
    GenServer.cast(GiocciEnginePubsub,{:update_RT,processing_time,finish})

  end

  def handle_cast({:reserve_start_utc,start_time}, before_data) do
    {:noreply, start_time}
  end

  def handle_call(:get_start_utc, _from , start_utc) do
    {:reply, start_utc,start_utc}
  end



end

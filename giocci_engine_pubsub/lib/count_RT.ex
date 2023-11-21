defmodule CountRT do
  use GenServer

  # def count_start do
  #   start = DateTime.utc_now()
  #   GenServer.cast(CountRT,{:reserve_start_utc,start})
  # end

  # def count_finish do
  #   finish = DateTime.utc_now()
  #   start = GenServer.call(CountRT,:get_start_utc)
  #   processing_time = 10000
  #   GenServer.cast(GiocciEnginePubsub,{:update_RT,processing_time,finish})

  # end



  def update_countRT do
    clock = DateTime.utc_now()
    processing_time = 10000
    GenServer.cast(GiocciEnginePubsub,{:update_RT,processing_time,clock})
  end

  # def handle_cast({:reserve_start_utc,start_time}, before_data) do
  #   {:noreply, start_time}
  # end

  # def handle_call(:get_start_utc, _from , start_utc) do
  #   {:reply, start_utc,start_utc}
  # end



  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def send_RT do
    GenServer.call(CountRT,{:send_RT, rt})
  end

  def init(init) do
    {:ok, []}

  end
  def handle_cast({:send_RT, rt}, rt_list) do
    new_rt = [rt | rt_list]
    {:noreply, new_rt}
  end


end

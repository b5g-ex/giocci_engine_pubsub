defmodule CountQueue do
  # use GenServer

  def count_queue do
    queue_number = GenServer.call(TaskQueue,:remaining_task)

  end

  def update_queue_number(number)do
    clock = DateTime.utc_now()
    GenServer.cast(GiocciEnginePubsub,{:update_queue_number, number, clock})
  end
  def main do
    number = count_queue()
    update_queue_number(number)
    Process.sleep(3000)
    spawn(main)
  end


  def count_process do
    # process = :cpu_sup.
  end
  def update_process_number(number)do
    clock = DateTime.utc_now()
    GenServer.cast(GiocciEnginePubsub,{:update_process_number, number, clock})
  end



end

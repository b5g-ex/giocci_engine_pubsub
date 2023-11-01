defmodule CountRT do
  # use GenServer

  def count_queue do
    queue_number = GenServer.call(TaskQueue,:remaining_task)

  end

  def update_queue_number do
    clock = DateTime.utc_now()
    GenServer.cast(GiocciEnginePubsub,{:update_queue_number, number, clock})
  end
  def main do
    number = count_queue()
    update_queue_number(number)
    Process.sleep(30000)
  end




end

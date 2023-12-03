defmodule CountQueue do
  use GenServer

  def count_queue do
    queue_number = GenServer.call(TaskQueue,:remaining_task)

  end

  def update_queue_number(number)do
    clock = DateTime.utc_now()
    GenServer.cast(GiocciEngineStatus,{:update_queue_number, number, clock})
  end
  def main do
    number = count_queue()
    update_queue_number(number)
    Process.sleep(1500)
    main()
  end


  def count_process do
    # process = :cpu_sup.
  end
  def update_process_number(number)do
    clock = DateTime.utc_now()
    GenServer.cast(GiocciEngineStatus,{:update_process_number, number, clock})
  end





  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end


  def init(init) do

    {:ok, []}
  end
  def handle_cast(:start, state) do
    main()
    {:noreply,state}
  end

end

defmodule CountQueue do
  use GenServer

  @moduledoc """
  job_queueの中にあるジョブの数を数えます
  """

  def count_queue do
    queue_number = GenServer.call(JobQueue, :remaining_task)
  end

  def update_queue_number(number) do
    clock = DateTime.utc_now()
    GenServer.cast(GiocciEngineStatus, {:update_queue_number, number, clock})
  end

  def count_and_update do
    number = count_queue()
    update_queue_number(number)
    Process.sleep(1500)
    count_and_update()
  end

  def count_process do
    # process = :cpu_sup.
  end

  def update_process_number(number) do
    clock = DateTime.utc_now()
    GenServer.cast(GiocciEngineStatus, {:update_process_number, number, clock})
  end

  # 周期ループ用のGenserver

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(init) do
    {:ok, []}
  end

  def handle_cast(:start, state) do
    count_and_update()
    {:noreply, state}
  end
end

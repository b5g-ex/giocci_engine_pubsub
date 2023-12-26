defmodule ExecuteClientGiocciJob do
  use GenServer
  @moduledoc """
  ジョブを実行する関数です。現在はダミーのジョブがあります。
  またjob_queueからジョブを読み込む機能と、実行時間を測定する機能が含まれています

  """

  def load_task(n) do
    data = GenServer.call(JobQueue, :get_newtask)
    execute_job(data)
    load_task(n)
  end

  def start_timemeasurment do
    start_clo = DateTime.utc_now()
  end

  def finish_timemeasurment do
    finish_clo = DateTime.utc_now()
  end

  def execute_job(data) do
    client_data = data

    start_clock = start_timemeasurment()
    Process.sleep(10000)
    finish_clock = finish_timemeasurment()
    processing_time = DateTime.diff(finish_clock, start_clock, :microsecond)
    GenServer.cast(CountRT, {:send_RT, processing_time})
  end

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(init) do
    {:ok, []}
  end

  def handle_cast(:start, state) do
    Stream.unfold(0, fn n -> load_task(n) end)
    {:noreply, state}
  end
end

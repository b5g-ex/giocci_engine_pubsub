defmodule GiocciEngineStatus do
  GenServer
  @moduledoc """
  Engineで取得した各種データを保管します
  """

  defstruct [:queue_number, :RT, :linux_info]

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(_initial) do
    state = %GiocciEngineStatus{}
    {:ok, state}
  end

  def handle_cast({:update_linux_data, memtotal, memfree, clock}, state) do
    new_state = %GiocciEngineStatus{
      state
      | linux_info: %{memtotal: memtotal, memfree: memfree, clock: clock}
    }

    {:noreply, new_state}
  end

  def handle_cast({:update_RT, processing_time, clock}, state) do
    new_state = %GiocciEngineStatus{state | RT: %{processing_time: processing_time, clock: clock}}
    {:noreply, new_state}
  end

  def handle_cast({:update_queue_number, queue_number, clock}, state) do
    new_state = %GiocciEngineStatus{
      state
      | queue_number: %{queue_number: queue_number, clock: clock}
    }

    {:noreply, new_state}
  end

  def handle_cast({:update_process_number, process_number, clock}, state) do
    new_state = %GiocciEngineStatus{
      state
      | queue_number: %{queue_number: process_number, clock: clock}
    }

    {:noreply, new_state}
  end

  def handle_call(:check_status, _from, state) do
    {:reply, state, state}
  end
end

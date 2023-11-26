defmodule GiocciEnginePubsub do

  use GenServer, shutdown: :infinity
  @moduledoc """
  Documentation for `GiocciEnginePubsub`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> GiocciEnginePubsub.hello()
      :world

  """
  defstruct [:queue_number ,:RT ,:linux_info ]

  def start_engine_pubsub do

    session = Zenohex.open
    Session.declare_subscriber(session, "to/engine", fn m-> callback(m,session) end)
    Session.declare_subscriber(session, "return_ftom/engine", fn m-> callbackrt(m,session) end)

    {:ok, publisher} = Session.declare_publisher(session, "to/faal")
    Publisher.put(publisher, "Hello zenoh?")
  end
  def publish(session, msg)do
    {:ok, publisher} = Session.declare_publisher(session, "to/faal")
    msg = GenServer.call(GiocciEnginePubsub,:check_status)
    Publisher.put(publisher, msg)
  end

  # def subscribe do
  #   session = Zenohex.open
  #   Session.declare_subscriber(session, "to/engine", fn m-> callback(m,session) end)

  # end

  def return_publish(session)do
    {:ok, publisher} = Session.declare_publisher(session, "return_from/engine")
    Publisher.put(publisher, "received")
  end

  defp callback(m,session) do
    IO.puts(m)
    return_publish(session)
  end

  defp callbackrt(m,session) do
    IO.puts(m)
    # return_publish(session)
  end
  # def getting_linux_meminfo() do
  #   # session = Zenohex.open
  #   # [memtotal, memfree |other ] = LinuxStatuRead.get_linux_meminfo()
  #   # memtotal
  #   # # memfree
  #   # clock = DateTime.utc_now()
  #   # %GiocciEnginePubsub{Linux_info: [memtotal, memfree, clock]}
  #   # publish(session,memtotal <> "," <>  memfree)
  # end

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end
  def init(initial) do
    state = %GiocciEnginePubsub{}
   {:ok, state}
  end




  def handle_cast({:update_linux_data,memtotal,memfree,clock}, state) do
    new_state = %GiocciEnginePubsub{state | linux_info: %{memtotal: memtotal, memfree: memfree, clock: clock}}
    {:noreply, new_state}
  end

  def handle_cast({:update_RT,processing_time,clock}, state) do
    new_state = %GiocciEnginePubsub{state | RT: %{processing_time: processing_time, clock: clock}}
    {:noreply, new_state}
  end

  def handle_cast({:update_queue_number,queue_number,clock}, state) do
    new_state = %GiocciEnginePubsub{state | queue_number: %{queue_number: queue_number, clock: clock}}
    {:noreply, new_state}
  end

  def handle_cast({:update_process_number,process_number,clock}, state) do
    new_state = %GiocciEnginePubsub{state | queue_number: %{queue_number: process_number, clock: clock}}
    {:noreply, new_state}
  end

  def handle_call(:check_status, from, state) do
    {:reply, state,state}
  end
  # def get_linux_meminfo() do
  #   File.read!("/proc/meminfo")
  #   |> String.split("\n", trim: true)
  #   |> List.delete(" ")
  #   # |> List.keyfind(:MemFree,0)
  # end

  # |> String.split(["\n"," "])






end

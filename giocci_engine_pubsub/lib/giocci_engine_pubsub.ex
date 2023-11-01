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
  def getting_linux_meminfo() do
    # session = Zenohex.open
    # [memtotal, memfree |other ] = LinuxStatuRead.get_linux_meminfo()
    # memtotal
    # memfree
    clock = DateTime.utc_now()
    %GiocciEnginePubsub{Linux_info: [memtotal, memfree, clock]}
    # publish(session,memtotal <> "," <>  memfree)
  end

  def init() do
    {:ok, %GiocciEnginePubsub{}}
  end

  def handle_cast({:update_linux_data,memtotal,memfree,clock}, state) do
    %GiocciEnginePubsub{linux_info: [memtotal, memfree, clock]}
    {:noreply, state}
  end

  def handle_cast({:update_RT,processing_time}, state) do
    %GiocciEnginePubsub{RT: [processing_time, clock]}
    {:noreply, state}
  end

  def handle_cast({:update_queue_number,queue_number,clock}, state) do
    %GiocciEnginePubsub{queue_number: [queue_number, clock]}
    {:noreply, state}
  end

  # def get_linux_meminfo() do
  #   File.read!("/proc/meminfo")
  #   |> String.split("\n", trim: true)
  #   |> List.delete(" ")
  #   # |> List.keyfind(:MemFree,0)
  # end

  # |> String.split(["\n"," "])






end

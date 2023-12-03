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


  def start_engine_pubsub do

    session = Zenohex.open
    GenServer.cast()
    Session.declare_subscriber(session, "to/engine", fn m-> callback(m,session) end)
    Session.declare_subscriber(session, "return_ftom/engine", fn m-> callbackrt(m,session) end)

    {:ok, publisher} = Session.declare_publisher(session, "to/faal")
    Publisher.put(publisher, "Hello zenoh?")
  end
  def publish(msg)do
    session =GenServer.call(GiocciEnginePubsub,:call_session)
    {:ok, publisher} = Session.declare_publisher(session, "to/faal")
    # msg = GenServer.call(GiocciEnginePubsub,:check_status)
    # Publisher.put(publisher, msg)
    msg = GenServer.call(GiocciEngineStatus,:check_status)
    Publisher.put(publisher, msg |> :erlang.term_to_binary |> Base.encode64)
  end

  # def subscribe do
  #   session = Zenohex.open
  #   Session.declare_subscriber(session, "to/engine", fn m-> callback(m,session) end)

  # end

  def return_publish()do
    session =GenServer.call(GiocciEnginePubsub,:call_session)
    {:ok, publisher} = Session.declare_publisher(session, "return_from/engine")
    Publisher.put(publisher, "received")
  end

  defp callback(m) do
    IO.puts(m)
    return_publish()
  end

  defp callbackrt(m) do
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


  # def get_linux_meminfo() do
  #   File.read!("/proc/meminfo")
  #   |> String.split("\n", trim: true)
  #   |> List.delete(" ")
  #   # |> List.keyfind(:MemFree,0)
  # end

  # |> String.split(["\n"," "])


  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end
  def init(session) do
   {:ok, session}
  end

  def handle_call(:call_session, from, session) do
    {:reply, session}
  end




end

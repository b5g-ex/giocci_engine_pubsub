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
  def hello do
    :world
  end

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
  def send_linux_meminfo() do
    session = Zenohex.open
    [memtotal, memfree |other ]=get_linux_meminfo()
    memtotal
    memfree
    publish(session,memtotal <> "," <>  memfree)
  end

  def get_linux_meminfo() do
    File.read!("/proc/meminfo")
    |> String.split("\n", trim: true)
    |> List.delete(" ")
    # |> List.keyfind(:MemFree,0)
  end

  # |> String.split(["\n"," "])








  defmodule TaskSimulator do
    use GenServer


    def init(init) do
      queue=:queue.new
      {:ok, queue}

    end

    def handle_call(:get_newtask,from, queue)do

      {task, queue} = :queue.out(queue)
      {:reply, task, queue}
    end

    def handle_call(:push_newtask,from, queue)do

      {task, queue} = :queue.in(queue)
      {:reply, task, queue}
    end

    def handle_info(:get_status, queue) do
      {:reply, queue}

    end





    def task_do do
      Process.sleep(100)
    end
  end

end




defmodule TaskSimulator do
  use GenServer


  def init(init) do
    queue=:queue.new
    {:ok, queue}

  end

  def handle_call(:get_newtask,from, queue)do

    {task, queue} = :queue.out(queue)
    {:reply, task, queue}
  end

  def handle_call(:push_newtask,from, queue)do

    {task, queue} = :queue.in(queue)
    {:reply, task, queue}
  end

  def handle_info(:get_status, queue) do
    {:reply, queue}

  end




end

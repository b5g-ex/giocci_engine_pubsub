defmodule GiocciEnginePubsub do
  use GenServer, shutdown: :infinity

  @moduledoc """
  Documentation for `GiocciEnginePubsub`.
  EngineとFaal間のpubsubを行います
  """



  def start_engine_pubsub do
    session = Zenohex.open()
    start_link(session)
    Session.declare_subscriber(session, "from/faal", fn m -> callback(m) end)
    Session.declare_subscriber(session, "from/client", fn m -> callbackcl(m) end)
    {:ok, publisher} = Session.declare_publisher(session, "from/engine")
    # Publisher.put(publisher, "zenoh")
  end

  def publish() do
    session = GenServer.call(GiocciEnginePubsub, :call_session)
    {:ok, publisher} = Session.declare_publisher(session, "from/engine")
    msg = GenServer.call(GiocciEngineStatus, :check_status)
    Publisher.put(publisher, msg |> :erlang.term_to_binary() |> Base.encode64())
  end

  def publishcl(msg) do
    # IO.inspect(msg)
    session = GenServer.call(GiocciEnginePubsub, :call_session)
    {:ok, publisher} = Session.declare_publisher(session, "from/engine2client")
    # IO.inspect(msg)

    Publisher.put(publisher, msg |> :erlang.term_to_binary() |> Base.encode64())
  end

  # def return_publish() do
  #   session = GenServer.call(GiocciEnginePubsub, :call_session)
  #   {:ok, publisher} = Session.declare_publisher(session, "return_from/engine")
  #   Publisher.put(publisher, "received")
  # end

  defp callback(m) do
    msg = m |> String.trim
            |> Base.decode64!
            |> String.trim
            |> :erlang.binary_to_term
    IO.inspect(msg)
  end
  defp callbackcl(m) do
    msg = m |> String.trim
            |> Base.decode64!
            |> String.trim
            |> :erlang.binary_to_term
    # msg = m
    # IO.inspect(msg)
    ClientJobFlow.load_task(msg)
  end

  def call(m)do
    msg = m |> String.trim
            |> Base.decode64!
            |> String.trim
            |> :erlang.binary_to_term
    IO.inspect(msg)
  end
  # defp callbackrt(m) do
  #   IO.puts(m)
  #   # return_publish(session)
  # end

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(session) do
    {:ok, session}
  end

  def handle_call(:call_session, _from, session) do
    {:reply, session, session}
  end
end

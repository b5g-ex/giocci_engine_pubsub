defmodule GiocciEnginePubsub do
  use GenServer, shutdown: :infinity

  @moduledoc """
  Documentation for `GiocciEnginePubsub`.
  EngineとFaal間のpubsubを行います
  """



  def start_engine_pubsub do
    session = Zenohex.open()
    start_link(session)
    Session.declare_subscriber(session, "to/engine", fn m -> callback(m) end)

    {:ok, publisher} = Session.declare_publisher(session, "to/faal")
    # Publisher.put(publisher, "zenoh")
  end

  def publish() do
    session = GenServer.call(GiocciEnginePubsub, :call_session)
    {:ok, publisher} = Session.declare_publisher(session, "to/faal")
    msg = GenServer.call(GiocciEngineStatus, :check_status)
    Publisher.put(publisher, msg |> :erlang.term_to_binary() |> Base.encode64())
  end

  def return_publish() do
    session = GenServer.call(GiocciEnginePubsub, :call_session)
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

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(session) do
    {:ok, session}
  end

  def handle_call(:call_session, from, session) do
    {:reply, session, session}
  end
end

defmodule ClientSimulatorPubsub do
  use GenServer
  @moduledoc """

  """

  def start_client_pubsub do
    session = Zenohex.open()
    start_link(session)
    Session.declare_subscriber(session, "from/engine2client", fn m -> callback(m) end)
    {:ok, publisher} = Session.declare_publisher(session, "from/client")
  end

  def publish() do
    session = GenServer.call(ClientSimulatorPubsub, :call_session)

    # msg =GenServer.call(ClientSimulatorGenerateJob, :get_task)
    testmodule = :code.get_object_code(IncMul2)|> :erlang.term_to_binary() |> Base.encode64()

    msg = [testmodule,fn (data)-> data |>IncMul2.inc |>IncMul2.mul2 end,[1,2,4,2,5]]
    # msg = [1,2,3,4,5]
    msg = msg |> :erlang.term_to_binary() |> Base.encode64()
    # IO.inspect(msg)
    {:ok, publisher} = Session.declare_publisher(session, "from/client")
    # msg ="aa"
    Publisher.put(publisher, msg)
  end

  def publish_repeat() do
    session = GenServer.call(ClientSimulatorPubsub, :call_session)
    {:ok, publisher} = Session.declare_publisher(session, "from/engine")
    msg =GenServer.call(ClientSimulatorGenerateJob, :get_task)
    Publisher.put(publisher, msg |> :erlang.term_to_binary() |> Base.encode64())
    Process.sleep(5000)
    publish_repeat()
  end


  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(session) do
    {:ok, session}
  end

  def handle_call(:call_session, _from, session) do
    {:reply, session, session}
  end

  def callback(m) do
    msg = m |> String.trim
            |> Base.decode64!
            |> :erlang.binary_to_term
    # msg = m
    IO.inspect(msg)

    # return_publish()
  end
end

defmodule ClientSimulatorPubsub do
  use GenServer
  @moduledoc """

  """

  def start_client_pubsub do
    session = Zenohex.open()
    start_link(session)
    Session.declare_subscriber(session, "from/engine", fn m -> callback(m) end)
    {:ok, publisher} = Session.declare_publisher(session, "from/client")
  end

  def publish() do
    session = GenServer.call(ClientSimulatorPubsub, :call_session)
    {:ok, publisher} = Session.declare_publisher(session, "from/client")
    # msg =GenServer.call(ClientSimulatorGenerateJob, :get_task)
    testmodule = :code.get_object_code(defmodule IncMul2 do
        def inc(x) do
          ans = x+1
        end
        def mul2(x) do
          ans2 = x+x
        end
      end
      )|> :erlang.term_to_binary() |> Base.encode64()
    # msg = ["defmodule Incmul2 do
    #   def inc (x) do
    #    ans = x +1
    #   end
    #   def mul2(x) do
    #   ans = x*2
    #   end
    #   end" ,
    #   "fn (data)->
    #   data |>inc |>mul2
    #   end",
    #   [1,2,4,2,5]]
    msg = [testmodule,fn (data)-> data |>ClientSimulatorPubsub.IncMul2.inc |>ClientSimulatorPubsub.IncMul2.mul2 end,[1,2,4,2,5]]

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

  defp callback(m) do
    IO.puts(m)
    # return_publish()
  end
end

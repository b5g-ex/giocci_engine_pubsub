defmodule GiocciEnginePubsub do
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
    # NifZenoh.tester_sub ("demo/example/zenoh-rs-pub")
    session = Zenohex.open
    Session.declare_subscriber(session, "to/engine", fn m-> callback(m,session) end)

    {:ok, publisher} = Session.declare_publisher(session, "to/faal")
    Publisher.put(publisher, "Hello zenoh?")
  end
  def publish (session)do
    {:ok, publisher} = Session.declare_publisher(session, "demo/example/zenoh-rs-pub")
    Publisher.put(publisher, "Hello zenoh?")
  end

  def subscribe do
    session = Zenohex.open
    Session.declare_subscriber(session, "to/engine", fn m-> callback(m,session) end)

  end

  defp callback(m,session) do
    IO.puts(m)
    # publish(session)
  end

end

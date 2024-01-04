defmodule ClientSimulatorGenerateJob do
  use GenServer
  @moduledoc """

  """



  def generate_client_job() do
    GenServer.call(ClientSimulatorGenerateJob, {:push_newtask, ["module","func_flow","data"]})
    Process.sleep(5000)
    generate_client_job()
  end

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(_init) do
    {:ok, []}
  end

  def handle_call({:push_newtask, newtask}, _from, queue) do
    new_queue = queue ++ [newtask]
    {:reply, new_queue, new_queue}
  end

  def handle_call(:get_task, _from, queue) do
    head = []
    tail = []

    case [] do
      ^queue ->
        head = []
        tail = []

      _ ->
        [head | tail] = queue
    end

    {:reply, head, tail}
  end

end

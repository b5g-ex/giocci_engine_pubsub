defmodule JobQueue do
  use GenServer

  @moduledoc """
  clientからのjobを保管します
  """

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(_init) do
    {:ok, []}
  end

  def handle_call(:get_newtask, _from, queue) do
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

  def handle_call({:push_newtask, newtask}, _from, queue) do
    new_queue = queue ++ [newtask]
    {:reply, new_queue, new_queue}
  end

  def handle_call(:remaining_task, _from, queue) do
    number = queue |> Enum.count()
    {:reply, number, queue}
  end
end

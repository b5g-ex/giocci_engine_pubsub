defmodule TaskQueue do
  use GenServer


  # def init(init) do
  #   queue=:queue.new
  #   {:ok, queue}

  # end

  # def handle_call(:get_newtask,from, queue)do

  #   {task, queue} = :queue.out(queue)
  #   {:reply, task, queue}
  # end

  # def handle_call(:push_newtask,from, queue)do

  #   {task, queue} = :queue.in(queue)
  #   {:reply, task, queue}
  # end

  # def handle_info(:get_status, queue) do
  #   {:reply, queue}

  # end

  def init(init) do
    {:ok, []}

  end

  def handle_call(:get_newtask,from, queue)do

    [head | tail]= queue
    {:reply, head, tail}
  end

  def handle_call({:push_newtask,newtask},from, queue)do
    new_queue = queue ++ [newtask]
    {:reply, new_queue, new_queue}
  end
  def handle_call(:remaining_task, from, queue) do
    number = len(queue)
    {:reply,number, queue}
  end

  # def handle_info(:get_status, queue) do
  #   {:reply, queue}

  # end


end

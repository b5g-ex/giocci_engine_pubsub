defmodule Tester.Tester do
  def tester1 do
    # GiocciEnginePubsub.start_link(1000)
    GiocciEngineStatus.start_link(1000)
    # CountQueue.start_link()
    TaskQueue.start_link(1000)
    CountRT.start_link(1000)
    CountQueue.start_link(1000)
    LinuxStatusRead.start_link(1000)
    GenServer.cast(CountQueue,:start)
    GenServer.cast(LinuxStatusRead,:start)
    GenServer.call(TaskQueue,{:push_newtask,1000})
    GenServer.call(TaskQueue,{:push_newtask,1000})
    GenServer.call(TaskQueue,{:push_newtask,1000})
    GenServer.call(TaskQueue,{:push_newtask,1000})
    TaskDo.main()
    # LinuxStatusRead.get_linux_meminfo()
    # CountQueue.main()
    CountRT.update_countRT
    GenServer.call(GiocciEngineStatus,:check_status)
    GiocciEnginePubsub.start_engine_pubsub
    GiocciEnginePubsub.publish()

  end





  def tester2 do

    GiocciEnginePubsub.start_link(1000)
    GiocciEngineStatus.start_link(1000)
    TaskQueue.start_link(1000)
    CountRT.start_link(1000)
    CountQueue.start_link(1000)
    LinuxStatusRead.start_link(1000)
    GenServer.cast(CountQueue,:start)
    GenServer.cast(LinuxStatusRead,:start)
    GenServer.call(TaskQueue,{:push_newtask,1000})
    GenServer.call(TaskQueue,{:push_newtask,1000})
    GenServer.call(TaskQueue,{:push_newtask,1000})
    GenServer.call(TaskQueue,{:push_newtask,1000})


    SigotoFlow.do_task()


    CountQueue.count_process()
    CountQueue.update_process_number()

    # GiocciEnginePubsub.publish(session)
  end

end

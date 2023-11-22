defmodule Tester.Tester do
  def tester1 do
    GiocciEnginePubsub.start_link(1000)
    # CountQueue.start_link()
    TaskQueue.start_link(1000)
    CountRT.start_link(1000)
    GenServer.call(TaskQueue,{:push_newtask,1000})
    GenServer.call(TaskQueue,{:push_newtask,1000})
    GenServer.call(TaskQueue,{:push_newtask,1000})
    GenServer.call(TaskQueue,{:push_newtask,1000})
    TaskDo.main()
    LinuxStatusRead.get_linux_meminfo()
    CountQueue.main()
    CountRT.update_countRT
    GenServer.call(GiocciEnginePubsub,:check_status)

  end

  def tester2 do

    GiocciEnginePubsub.start_engine_pubsub()
    GiocciEnginePubsub.start_link()
    # CountQueue.start_link()
    CountRT.start_link()

    ModuleFlow.do_task()

    LinuxStatusRead.get_linux_meminfo()
    CountQueue.count_process()
    CountQueue.update_process_number()

    # GiocciEnginePubsub.publish(session)
  end

end

defmodule Tester.Tester do
  def tester1 do
    GiocciEnginePubsub.start_link()
    # CountQueue.start_link()
    TaskQueue.start_link()
    TaskDo.main()

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

    GiocciEnginePubsub.publish(session)
  end

end

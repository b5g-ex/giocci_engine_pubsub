defmodule Tester.TesterEngine do
  def tester1 do
    # GiocciEnginePubsub.start_link(1000)
    GiocciEngineStatus.start_link(1000)
    # CountQueue.start_link()
    JobQueue.start_link(1000)
    CountRT.start_link(1000)
    CountQueue.start_link(1000)
    LinuxStatusRead.start_link(1000)
    GenServer.cast(CountQueue, :start)
    GenServer.cast(LinuxStatusRead, :start)
    GenServer.call(JobQueue, {:push_newtask, 1000})
    GenServer.call(JobQueue, {:push_newtask, 1000})
    GenServer.call(JobQueue, {:push_newtask, 1000})
    GenServer.call(JobQueue, {:push_newtask, 1000})
    ExecuteClientGiocciJob.execute_job()
    # LinuxStatusRead.get_linux_meminfo()
    # CountQueue.main()
    CountRT.update_countRT()
    GenServer.call(GiocciEngineStatus, :check_status)
    GiocciEnginePubsub.start_engine_pubsub()
    GiocciEnginePubsub.publish()
  end

  def tester_start do
    GiocciEngineStatus.start_link(1000)
    JobQueue.start_link(1000)
    CountRT.start_link(1000)
    ExecuteClientGiocciJob.start_link(1000)
    CountQueue.start_link(1000)
    LinuxStatusRead.start_link(1000)
    GenServer.call(GiocciEngineStatus, :check_status)
  end

  def tester_start_cyclic_job do
    GenServer.cast(CountQueue, :start)
    GenServer.cast(LinuxStatusRead, :start)
    # GenServer.call(GiocciEngineStatus, :check_status)
  end

  def tester_push_job do
    GenServer.call(JobQueue, {:push_newtask, 1000})
    GenServer.call(JobQueue, {:push_newtask, 1000})
    GenServer.call(JobQueue, {:push_newtask, 1000})
    GenServer.call(JobQueue, {:push_newtask, 1000})
    GenServer.call(JobQueue, {:push_newtask, 1000})
    GenServer.call(JobQueue, {:push_newtask, 1000})
    GenServer.call(JobQueue, {:push_newtask, 1000})
    GenServer.call(JobQueue, {:push_newtask, 1000})
    GenServer.call(JobQueue, {:push_newtask, 1000})
    GenServer.call(JobQueue, {:push_newtask, 1000})
    GenServer.call(JobQueue, {:push_newtask, 1000})
    GenServer.call(JobQueue, {:push_newtask, 1000})
  end

  def tester_execute_job do
    GenServer.cast(ExecuteClientGiocciJob, :start)
    # CountRT.update_countRT

  end

  def tester_pubsub do
    GiocciEnginePubsub.start_engine_pubsub()
    GiocciEnginePubsub.publish()
  end

  def tester_check_status do
    GenServer.call(GiocciEngineStatus, :check_status)
  end

  def tester2 do
    GiocciEnginePubsub.start_link(1000)
    GiocciEngineStatus.start_link(1000)
    JobQueue.start_link(1000)
    CountRT.start_link(1000)
    CountQueue.start_link(1000)
    LinuxStatusRead.start_link(1000)
    GenServer.cast(CountQueue, :start)
    GenServer.cast(LinuxStatusRead, :start)
    GenServer.call(JobQueue, {:push_newtask, 1000})
    GenServer.call(JobQueue, {:push_newtask, 1000})
    GenServer.call(JobQueue, {:push_newtask, 1000})
    GenServer.call(JobQueue, {:push_newtask, 1000})

    SigotoFlow.do_task()

    CountQueue.count_process()
    CountQueue.update_process_number()

    # GiocciEnginePubsub.publish(session)
  end
end

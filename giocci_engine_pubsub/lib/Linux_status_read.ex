defmodule LinuxStatusRead do
  # def send_linux_meminfo() do
  #   session = Zenohex.open
  #   [memtotal, memfree |other ]=get_linux_meminfo()
  #   memtotal
  #   memfree
  #   publish(session,memtotal <> "," <>  memfree)
  # end

  def get_linux_meminfo() do
    [memtotal, memfree |other ] =
      File.read!("/proc/meminfo")
      |> String.split("\n", trim: true)
      |> List.delete(" ")
    # |> List.keyfind(:MemFree,0)

    clock = DateTime.utc_now()
    GenServer.cast(GiocciEngineStatus,{:update_linux_data,memtotal,memfree,clock})
    Process.sleep(2000)
    get_linux_meminfo()
  end

end

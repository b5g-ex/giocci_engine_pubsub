defmodule LinuxStatusRead do
  # def send_linux_meminfo() do
  #   session = Zenohex.open
  #   [memtotal, memfree |other ]=get_linux_meminfo()
  #   memtotal
  #   memfree
  #   publish(session,memtotal <> "," <>  memfree)
  # end

  def get_linux_meminfo() do
    File.read!("/proc/meminfo")
    |> String.split("\n", trim: true)
    |> List.delete(" ")
    # |> List.keyfind(:MemFree,0)
  end

end

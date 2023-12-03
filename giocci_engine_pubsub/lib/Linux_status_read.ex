defmodule LinuxStatusRead do
  GenServer
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



  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end


  def init(init) do

    {:ok, []}
  end
  def handle_cast(:start, state) do
    get_linux_meminfo()
    {:noreply,state}
  end

end

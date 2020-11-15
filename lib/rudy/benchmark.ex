defmodule Rudy.Benchmark do
  alias Rudy.HTTP

  def benchmark(host \\ 'localhost', port \\ 4000, iterations \\ 100) do
    data = for _ <- 1..iterations, do: do_benchmark(host, port)
    avg(data)
  end

  def do_benchmark(host, port) do
    {time, _} = :timer.tc(fn -> run(100, host, port) end)
    IO.inspect(time / 1_000_000, label: "seconds")
  end

  def avg(list) do
    result =
      list
      |> Enum.reduce(0, fn n, acc -> n + acc end)
      |> Kernel./(length(list))
      |> Float.round(4)

    IO.puts("On average, it takes #{result} seconds for the HTTP server to handle 100 requests")
    result
  end

  defp run(0, _host, _port), do: :ok

  defp run(n, host, port) do
    request(host, port)
    run(n - 1, host, port)
  end

  defp request(host, port) do
    opts = [:list, active: false, reuseaddr: true]
    {:ok, server} = :gen_tcp.connect(host, port, opts)
    :gen_tcp.send(server, HTTP.get("/index.html"))

    case :gen_tcp.recv(server, 0) do
      {:ok, _} -> :ok
      {:error, error} -> IO.inspect("benchmark: error: #{inspect(error)}")
    end

    :gen_tcp.close(server)
  end
end

defmodule Test do
  def test do
    start = :erlang.system_time(:micro_seconds)
    :timer.sleep(1_000)
    finish = :erlang.system_time(:micro_seconds)

    (finish - start) / 1_000_000
  end
end

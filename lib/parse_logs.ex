defmodule ParseLogs do
  use Application

  def start(_type, _args) do
    files = [
      {"base64-image", ParseLogs.Base64Image},
      {"base64-video", ParseLogs.Base64Video},
      {"cpu", ParseLogs.Cpu},
      {"load-page", ParseLogs.LoadPage},
      {"memory", ParseLogs.Memory},
      {"restarts", ParseLogs.Restarts},
      # {"sent-200", ParseLogs.Sent200}, bunch of overlap with load-page. not sure it's necessary
      {"total-subscribers", ParseLogs.TotalSubscribers},
    ]

    pids = Enum.map(files, fn({path, module}) ->
      Task.async(fn ->
        process(path, module)
      end)
    end)

    pids |> Enum.each(fn(pid) -> Task.await(pid, 30_000) end)
    {:ok, self}
  end

  defp process(log_name, mod) do
    in_file = File.open! "log_data/#{log_name}.log", [:read, :utf8]
    out_file = File.open! "log_data/#{log_name}.csv", [:write, :utf8]

    IO.puts out_file, mod.header

    for line <- IO.stream(in_file, :line) do
      parsed_line = mod.parse_line(line)
      if parsed_line != :skip, do: IO.puts(out_file, parsed_line)
    end

    File.close in_file
    File.close out_file
  end
end


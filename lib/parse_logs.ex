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

    # summarize()

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

  # defp summarize do
  #   cpu_file = File.open! "log_data/cpu.csv", [:read, :utf8]
  #   load_file = File.open! "log_data/load-page.csv", [:read, :utf8]
  #   mem_file = File.open! "log_data/memory.csv", [:read, :utf8]
  #   subs_file = File.open! "log_data/total-subscribers.csv", [:read, :utf8]
  #   sum_file = File.open! "log_data/summary.csv", [:write, :utf8]


  #   # skip headers
  #   [cpu_file, load_file, mem_file, subs_file] |> Enum.each(fn file -> IO.read file)
  #   IO.puts sum_file, "time,cpu min, cpu max, cpu avg"

  #   min_ts = 14313951
  #   max_ts = 14313959
  #   # max_ts = 14317301
  #   current_ts = min_ts

  #   cpu_line = File.read cpu_file
  #   load_line = File.read load_file
  #   memory_line = File.read memory_file
  #   subs_line = File.read subs_file

  #   initial_cpu_data = cpu_data_from_line(File.read(cpu_file))

  #   min_ts..max_ts |> Enum.reduce(%{} , fn ts, prev_data ->
  #     {cpu_min, cpu_max, cpu_avg} = data_for_cpu(ts, last_data, cpu_file)
  #     ts
  #   end)


  #   File.close cpu_file
  #   File.close load_file
  #   File.close memory_file
  #   File.close total_subs_file
  # end

  # defp data_for_cpu(ts, last_data, cpu_file) do
  #   {lines, last_read_line}
  # end

  # # recursive function that returns a list of loads for a given timestamp
  # defp lines_for_ts(file, ts, data_for_this_ts, last_read_line) do
  #   if last_line.ts > ts do
  #     {data_for_this_ts, last_read_line}
  #   else
  #     next_line = File.read file
  #     data = cpu_data_from_line(next_line)
  #     lines_for_ts(file, ts, [data | data_for_this_ts], next_line)
  #   end
  # end
end


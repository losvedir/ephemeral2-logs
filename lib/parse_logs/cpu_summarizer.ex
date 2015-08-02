defmodule ParseLogs.CpuSummarizer do

  # takes a pid for a file with no header, expects the file
  # to be of the form:
  #
  # 123456,0.50
  # 123456,0.49
  # 123457,1.1
  #
  # that is, the timestamp in unix time and the load. Writes to a file
  # like
  # ts,min,max,avg
  # 123456,0.49,0.50,0.495
  def summarize(in_file, out_file, min_ts, max_ts) do
    in_file_pid = File.open! in_file, [:read, :utf8]
    out_file_pid = File.open! out_file, [:write, :utf8]

    IO.read in_file_pid, :line # clear header
    IO.puts out_file_pid, "ts,min,max,avg"

    summarize(max_ts, min_ts, in_file_pid, out_file_pid, [], read_next_datum(in_file_pid))

    File.close in_file_pid
    File.close out_file_pid
  end

  defp read_next_datum(file_pid) do
    next = IO.read file_pid, :line

    if next == :eof do
      :eof
    else
      cpu_data_from_line(next)
    end
  end

  defp summarize(max_ts, current_ts, in_file, out_file, data_for_ts, next_datum) do
    if current_ts > max_ts do
      {min, max, avg} = analyze_data(data_for_ts)
      IO.puts out_file, "#{current_ts},#{min},#{max},#{avg}"
      File.close out_file
      :ok
    else
      if next_datum == :eof do
        {min, max, avg} = analyze_data(data_for_ts)
        IO.puts out_file, "#{current_ts},#{min},#{max},#{avg}"
        summarize(max_ts, current_ts+1, in_file, out_file, [], :eof)
      else
        if next_datum[:ts] == current_ts do
          summarize(max_ts, current_ts, in_file, out_file, [next_datum|data_for_ts], read_next_datum(in_file))
        else
          if next_datum[:ts] > current_ts do
            {min, max, avg} = analyze_data(data_for_ts)
            IO.puts "#{current_ts},#{min},#{max},#{avg}"
            summarize(max_ts, current_ts+1, in_file, out_file, [], next_datum)
          else
          end
        end
      end
    end
  end

  defp analyze_data(data) do
    {"min", "max", "avg"}
  end

  # takes a line from the CPU file, and returns { timestamp/100, load }
  defp cpu_data_from_line(line) do
    regex = ~r/(\d+),(.*)\n/
    [ts, load] = Regex.run regex, line, capture: :all_but_first
    ts_grp = (String.to_float(ts)/100) |> Float.floor |> trunc
    {ts_grp, String.to_float(load)}
  end
end

defmodule ParseLogs.CpuSummarizerData do
  defstruct current_ts: 0
end

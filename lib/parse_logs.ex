defmodule ParseLogs do
  use Application

  def start(_type, _args) do
    files = [
      {"base64-video", ParseLogs.Base64Video},
      {"base64-image", ParseLogs.Base64Image},
      {"sent-200", ParseLogs.Sent200},
    ]

    for {path, module} <- files, do: process(path, module)
    wait(0)
  end

  defp process(log_name, mod) do
    parent = self
    in_file = File.open! "log_data/#{log_name}.log", [:read, :utf8]
    out_file = File.open! "log_data/#{log_name}.csv", [:write, :utf8]

    spawn fn ->
      IO.puts out_file, mod.header

      for line <- IO.stream(in_file, :line) do
        parsed_line = mod.parse_line(line)
        if parsed_line, do: IO.puts(out_file, parsed_line)
      end

      File.close in_file
      File.close out_file
      send parent, :done
    end
  end

  defp wait(n) do
    if n == 2 do
      {:ok, self}
    else
      receive do
        :done ->
          IO.puts "Received a :done"
          wait(n+1)
      end
    end
  end
end


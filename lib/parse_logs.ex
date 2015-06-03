defmodule ParseLogs do
  use Application

  def start(_type, _args) do
    files = [
      # commenting out for now. how to run tests without invoking the file processing?
      # i think start shouldn't kick off the processing, maybe.
      # {"base64-video", ParseLogs.Base64Video},
      # {"base64-image", ParseLogs.Base64Image},
      # {"sent-200", ParseLogs.Sent200},
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
      if parsed_line, do: IO.puts(out_file, parsed_line)
    end

    File.close in_file
    File.close out_file
  end
end


read_pid = File.open! "base64-video.log", [:read, :utf8]
write_pid = File.open! "base64-video-processed.csv", [:write, :utf8]

IO.write write_pid, "timestamp\n"

for line <- IO.stream(read_pid, :line) do
  [ts|_] = Regex.run(~r/198 <190>1 (.*) app web.1.*/, line, capture: :all_but_first)
  IO.write write_pid, ts <> "\n"
end

File.close read_pid
File.close write_pid

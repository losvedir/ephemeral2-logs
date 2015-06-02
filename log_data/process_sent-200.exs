read_pid = File.open! "sent-200.log", [:read, :utf8]
write_pid = File.open! "sen-200-processed.csv", [:write, :utf8]

IO.write write_pid, "timestamp,time\n"

for line <- IO.stream(read_pid, :line) do
  try do
    [ ts | [time|_] ] = Regex.run ~r/^d? ?... <...>. (.*) app web.*Sent [5|2]00 in (.*)/, line, capture: :all_but_first
    IO.write write_pid, "#{ts},#{time}\n"
  rescue
    e in MatchError ->
      IO.inspect "----------- here -----------"
      IO.inspect line
      raise e
  end
end

File.close read_pid
File.close write_pid

defmodule ParseLogs.Sent200 do
  def header do
    "timestamp,status,time in µs"
  end

  def parse_line(line) do
    [ ts | [time|_] ] = Regex.run ~r/^d? ?... <...>. (.*) app web.*Sent [5|2]00 in (.*)/, line, capture: :all_but_first
    "#{ts},#{time}"
  end
end

defmodule ParseLogs.Cpu do
  def header do
    "timestamp,load_avg_1m"
  end

  def parse_line(line) do
    regex = ~r/\d\d\d <45>1 (.*) heroku web.1 .*sample#load_avg_1m=([0-9.]+)/
    [ts | [ load_avg | _]] = Regex.run regex, line, capture: :all_but_first

    {:ok, mvd} = Calendar.DateTime.Parse.rfc3339 ts, "Etc/UTC"
    ts = mvd |> Calendar.DateTime.Format.unix

    "#{ts},#{load_avg}"
  end
end

defmodule ParseLogs.Cpu do
  def header do
    "timestamp,load_avg_5m"
  end

  def parse_line(line) do
    try do
      regex = ~r/\d\d\d <45>1 (.*) heroku web.1 .*sample#load_avg_5m=([0-9.]+)/
      [ts | [ load_avg | _]] = Regex.run regex, line, capture: :all_but_first
      ts = ParseLogs.Utils.heroku_to_unix(ts)

      "#{ts},#{load_avg}"
    rescue
      e in MatchError ->
        :skip
    end
  end
end

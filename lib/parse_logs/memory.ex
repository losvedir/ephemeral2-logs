defmodule ParseLogs.Memory do
  def header do
    "timestamp,memory"
  end

  def parse_line(line) do
    regex = ~r/\d\d\d <45>1 (.*) heroku web.1.*sample#memory_total=(.*)MB sample#memory_rss/
    [ts|[memory|_]] = Regex.run regex, line, capture: :all_but_first
    ts = ParseLogs.Utils.heroku_to_unix(ts)

    "#{ts},#{memory}"
  end
end

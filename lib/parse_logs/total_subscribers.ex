defmodule ParseLogs.TotalSubscribers do
  def header do
    "timestamp,count"
  end

  def parse_line(line) do
    regex = ~r/\d\d\d <190>1 (.*) app web.* total_subscribers=(.*)/
    [ts|[subs|_]] = Regex.run regex, line, capture: :all_but_first
    ts = ParseLogs.Utils.heroku_to_unix(ts)

    "#{ts},#{subs}"
  end
end

defmodule ParseLogs.TotalSubscribers do
  def header do
    "timestamp,count"
  end

  def parse_line(line) do
    regex = ~r/\d\d\d <190>1 (.*) app web.* total_subscribers=(.*)/
    [ts|[subs|_]] = Regex.run regex, line, capture: :all_but_first

    {:ok, mvd} = Calendar.DateTime.Parse.rfc3339 ts, "Etc/UTC"
    ts = mvd |> Calendar.DateTime.Format.unix

    "#{ts},#{subs}"
  end
end

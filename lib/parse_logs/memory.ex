defmodule ParseLogs.Memory do
  def header do
    "timestamp,memory"
  end

  def parse_line(line) do
    regex = ~r/\d\d\d <45>1 (.*) heroku web.1.*sample#memory_total=(.*)MB sample#memory_rss/
    [ts|[memory|_]] = Regex.run regex, line, capture: :all_but_first

    {:ok, mvd} = Calendar.DateTime.Parse.rfc3339 ts, "Etc/UTC"
    ts = mvd |> Calendar.DateTime.Format.unix

    "#{ts},#{memory}"
  end
end

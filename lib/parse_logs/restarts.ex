defmodule ParseLogs.Restarts do
  def header do
    "timestamp"
  end

  def parse_line(line) do
    regex = ~r/\d\d\d <45>1 (.*) heroku web/
    [ts|_] = Regex.run regex, line, capture: :all_but_first
    ts = ParseLogs.Utils.heroku_to_unix(ts)

    "#{ts}"
  end
end

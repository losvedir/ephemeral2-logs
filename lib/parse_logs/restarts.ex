defmodule ParseLogs.Restarts do
  def header do
    "timestamp"
  end

  def parse_line(line) do
    regex = ~r/\d\d\d <45>1 (.*) heroku web/
    [ts|_] = Regex.run regex, line, capture: :all_but_first

    {:ok, mvd} = Calendar.DateTime.Parse.rfc3339 ts, "Etc/UTC"
    ts = mvd |> Calendar.DateTime.Format.unix

    "#{ts}"
  end
end

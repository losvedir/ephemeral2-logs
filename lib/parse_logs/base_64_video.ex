defmodule ParseLogs.Base64Video do
  def header do
    "timestamp"
  end

  def parse_line(line) do
    [ts|_] = Regex.run(~r/198 <190>1 (.*) app web.1.*/, line, capture: :all_but_first)
    ts

    {:ok, mvd} = Calendar.DateTime.Parse.rfc3339 ts, "Etc/UTC"
    mvd |> Calendar.DateTime.Format.unix
  end
end

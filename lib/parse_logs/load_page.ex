defmodule ParseLogs.LoadPage do
  def header do
    "timestamp,connect,service,status"
  end

  def parse_line(line) do
    regex = ~r/^\d\d\d <158>1 (.*) heroku router.*connect=(.*)ms service=(.*)ms status=(.*) bytes/
    try do
      [ts|[connect|[service|[status|_]]]] = Regex.run regex, line, capture: :all_but_first
      {:ok, mvd} = Calendar.DateTime.Parse.rfc3339 ts, "Etc/UTC"
      ts = mvd |> Calendar.DateTime.Format.unix

      "#{ts},#{connect},#{service},#{status}"
    rescue
      e in MatchError ->
        IO.puts line
        raise e
    end
  end
end

defmodule ParseLogs.Utils do
  def heroku_to_unix(heroku_time_string) do
    {:ok, cal_time} = Calendar.DateTime.Parse.rfc3339 heroku_time_string, "Etc/UTC"
    cal_time |> Calendar.DateTime.Format.unix
  end
end

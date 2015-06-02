defmodule ParseLogs.Base64Video do
  def header do
    "timestamp"
  end

  def parse_line(line) do
    [ts|_] = Regex.run(~r/198 <190>1 (.*) app web.1.*/, line, capture: :all_but_first)
    ts
  end
end

defmodule RestartsTest do
  use ExUnit.Case

  test "header/0" do
    "timestamp"
  end

  test "parse_line/1" do
    l1 = "129 <45>1 2015-05-12T01:45:18.040273+00:00 heroku web.1 - - State changed from starting to up"
    assert ParseLogs.Restarts.parse_line(l1) == "1431395118"
  end
end

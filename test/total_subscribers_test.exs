defmodule TotalSubscribersTest do
  use ExUnit.Case

  test "header/0" do
    "timestamp,count"
  end

  test "parse_line/1" do
    l1 = "133 <190>1 2015-05-12T09:16:31.769389+00:00 app web.1 - - 09:16:31.769 [info] total_subscribers=0"
    l2 = "135 <190>1 2015-05-12T13:38:53.928592+00:00 app web.1 - - 13:38:53.928 [info] total_subscribers=300"
    l3 = "135 <190>1 2015-05-12T15:07:36.604235+00:00 app web.1 - - 15:07:36.591 [info] total_subscribers=546"

    assert ParseLogs.TotalSubscribers.parse_line(l1) == "1431422191,0"
    assert ParseLogs.TotalSubscribers.parse_line(l2) == "1431437933,300"
    assert ParseLogs.TotalSubscribers.parse_line(l3) == "1431443256,546"
  end
end

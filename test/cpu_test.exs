defmodule CpuTest do
  use ExUnit.Case

  test "header/0" do
    "timestamp,load_avg_1m"
  end

  test "parse_line/1" do
    l1 = "190 <45>1 2015-05-12T01:46:10.218096+00:00 heroku web.1 - - source=web.1 dyno=heroku.34921046.7aef9231-b8f6-428b-8bc0-60689bb2b584 sample#load_avg_1m=0.00"
    l2 = "214 <45>1 2015-05-12T01:52:36.978599+00:00 heroku web.1 - - source=web.1 dyno=heroku.34921046.b1dc0c77-8163-434f-9048-d3e7b5dbdca5 sample#load_avg_1m=0.00 sample#load_avg_5m=0.00"
    l3 = "239 <45>1 2015-05-12T02:03:07.011087+00:00 heroku web.1 - - source=web.1 dyno=heroku.34921046.b1dc0c77-8163-434f-9048-d3e7b5dbdca5 sample#load_avg_1m=0.00 sample#load_avg_5m=0.00 sample#load_avg_15m=0.00"
    l4 = "214 <45>1 2015-05-12T12:49:12.461593+00:00 heroku web.1 - - source=web.1 dyno=heroku.34921046.a839b446-b160-4b1d-a7d8-f30d6412d95b sample#load_avg_1m=0.00 sample#load_avg_5m=0.00"
    l5 = "239 <45>1 2015-05-12T13:15:14.328322+00:00 heroku web.1 - - source=web.1 dyno=heroku.34921046.a839b446-b160-4b1d-a7d8-f30d6412d95b sample#load_avg_1m=0.54 sample#load_avg_5m=1.35 sample#load_avg_15m=1.09"

    assert ParseLogs.Base64Video.parse_line(l1) == "1431452801,0.00"
    assert ParseLogs.Base64Video.parse_line(l2) == "1431452801,0.00"
    assert ParseLogs.Base64Video.parse_line(l3) == "1431452801,0.00"
    assert ParseLogs.Base64Video.parse_line(l4) == "1431452801,0.00"
    assert ParseLogs.Base64Video.parse_line(l5) == "1431452801,0.54"
  end
end

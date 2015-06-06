defmodule MemoryTest do
  use ExUnit.Case

  test "header/0" do
    "timestamp,memory"
  end

  test "parse_line/1" do
    l1 = ~s(345 <45>1 2015-05-12T17:47:18.857418+00:00 heroku web.1 - - source=web.1 dyno=heroku.34921046.a839b446-b160-4b1d-a7d8-f30d6412d95b sample#memory_total=381.24MB sample#memory_rss=364.25MB sample#memory_cache=1.22MB sample#memory_swap=15.77MB sample#memory_pgpgin=9361957pages sample#memory_pgpgout=9268396pages)
    l2 = ~s(347 <45>1 2015-05-12T23:18:48.203698+00:00 heroku web.1 - - source=web.1 dyno=heroku.34921046.06879202-9973-4a56-b031-3b6adcd3ee8b sample#memory_total=425.38MB sample#memory_rss=379.70MB sample#memory_cache=0.47MB sample#memory_swap=45.21MB sample#memory_pgpgin=46057376pages sample#memory_pgpgout=45960053pages)
    l3 = ~s(340 <45>1 2015-05-15T22:24:37.508573+00:00 heroku web.1 - - source=web.1 dyno=heroku.34921046.c0bde949-e87b-4006-ab41-b5cf2b15a6cc sample#memory_total=115.31MB sample#memory_rss=112.66MB sample#memory_cache=1.55MB sample#memory_swap=1.11MB sample#memory_pgpgin=99025pages sample#memory_pgpgout=69789pages)
    l4 = ~s(336 <45>1 2015-05-12T01:45:26.295061+00:00 heroku web.1 - - source=web.1 dyno=heroku.34921046.7aef9231-b8f6-428b-8bc0-60689bb2b584 sample#memory_total=33.34MB sample#memory_rss=32.88MB sample#memory_cache=0.46MB sample#memory_swap=0.00MB sample#memory_pgpgin=9971pages sample#memory_pgpgout=1435pages)

    assert ParseLogs.Memory.parse_line(l1) == "1431452838,381.24"
    assert ParseLogs.Memory.parse_line(l2) == "1431472728,425.38"
    assert ParseLogs.Memory.parse_line(l3) == "1431728677,115.31"
    assert ParseLogs.Memory.parse_line(l4) == "1431395126,33.34"
  end
end

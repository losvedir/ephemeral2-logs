defmodule LoadPageTest do
  use ExUnit.Case

  test "header/0" do
    "timestamp,connect,service,status"
  end

  test "parse_line/1" do
    l1 = ~s(342 <158>1 2015-05-12T13:19:53.089058+00:00 heroku router - - at=info method=GET path="/2bbbf21959178ef2f935e90fc60e5b6e368d27514fe305ca7dcecc32c0134838" host=ephemeralp2p.durazo.us request_id=e4a2ff6c-27c4-45c1-a97b-bc75204af065 fwd="93.34.60.136" dyno=web.1 connect=1ms service=11ms status=200 bytes=1450)
    l2 = ~s(396 <158>1 2015-05-12T18:27:15.834333+00:00 heroku router - - at=error code=H13 desc="Connection closed without response" method=GET path="/2bbbf21959178ef2f935e90fc60e5b6e368d27514fe305ca7dcecc32c0134838" host=ephemeralp2p.durazo.us request_id=a84a62c8-7b79-463c-9db3-29ba69dd4758 fwd="128.119.40.196" dyno=web.1 connect=1ms service=10512ms status=503 bytes=0)
    l3 = ~s(341 <158>1 2015-05-12T18:33:11.201252+00:00 heroku router - - at=info method=GET path="/2bbbf21959178ef2f935e90fc60e5b6e368d27514fe305ca7dcecc32c0134838" host=ephemeralp2p.durazo.us request_id=abdeec8f-6b6f-4185-baad-d08d2dc56027 fwd="46.236.26.102" dyno=web.1 connect=7ms service=8ms status=406 bytes=226)

    assert ParseLogs.Base64Video.parse_line(l1) == "1431452801,1,11,200"
    assert ParseLogs.Base64Video.parse_line(l2) == "1431452801,1,10512,503"
    assert ParseLogs.Base64Video.parse_line(l3) == "1431452801,7,8,406"
  end
end

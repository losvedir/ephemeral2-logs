defmodule Base64VideoTest do
  use ExUnit.Case

  test "header/0" do
    assert ParseLogs.Base64Video.header == "timestamp"
  end

  test "parse_line/1" do
    log_line = "198 <190>1 2015-05-12T17:46:41.072613+00:00 app web.1 - - 17:46:41.072 [info] Joined HaveChannel: 5264b0eea08fc0f6c8c164815c30ddc76259851838813a1e7a9a4050802d7e5b"
    assert ParseLogs.Base64Video.parse_line(log_line) == 1431452801
  end
end

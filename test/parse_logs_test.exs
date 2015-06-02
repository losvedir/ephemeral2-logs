defmodule ParseLogsTest do
  use ExUnit.Case

  test "Base64Video header" do
    assert ParseLogs.Base64Video.header == "timestamp"
  end

  test "Base64Video parse_line" do
    log_line = "198 <190>1 2015-05-12T17:46:41.072613+00:00 app web.1 - - 17:46:41.072 [info] Joined HaveChannel: 5264b0eea08fc0f6c8c164815c30ddc76259851838813a1e7a9a4050802d7e5b"
    assert ParseLogs.Base64Video.parse_line(log_line) == "2015-05-12T17:46:41.072613+00:00"
  end

  test "Base64Image header" do
    assert ParseLogs.Base64Image.header == "timestamp"
  end

  test "Base64Image parse_line" do
    log_line = "198 <190>1 2015-05-12T13:15:11.055146+00:00 app web.1 - - 13:15:11.054 [info] Joined HaveChannel: 82d78987fd1cd530302b81d5643739dd9b22f7f7214f10c771b5327729d88fe9"
    assert ParseLogs.Base64Image.parse_line(log_line) == "2015-05-12T13:15:11.055146+00:00"
  end
end

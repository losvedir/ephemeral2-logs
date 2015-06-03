defmodule Base64ImageTest do
  use ExUnit.Case

  test "header/0" do
    assert ParseLogs.Base64Image.header == "timestamp"
  end

  test "parse_line/1" do
    log_line = "198 <190>1 2015-05-12T13:15:11.055146+00:00 app web.1 - - 13:15:11.054 [info] Joined HaveChannel: 82d78987fd1cd530302b81d5643739dd9b22f7f7214f10c771b5327729d88fe9"
    assert ParseLogs.Base64Image.parse_line(log_line) == "2015-05-12T13:15:11.055146+00:00"
  end
end

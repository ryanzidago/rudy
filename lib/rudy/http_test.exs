defmodule Rudy.HTTPTest do
  use ExUnit.Case
  alias Rudy.HTTP

  describe "parse_request/1" do
    test "returns a three-element tuple with in form of {request, headers, body}" do
      assert {{:get, "/index.html", :v11}, "foo 34", "Hello"} =
               HTTP.parse_request("GET /index.html HTTP/1.1\r\nfoo 34\r\n\r\nHello")
    end
  end

  describe "ok/1" do
    test "returns a HTTP reply with a 200 status code and the body concatenated at the end of the reply" do
      assert "HTTP/1.1 200 OK\r\n" <> "\r\n" <> "some reply" = HTTP.ok("some reply")
    end
  end
end

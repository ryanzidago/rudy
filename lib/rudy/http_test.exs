defmodule Rudy.HTTPTest do
  use ExUnit.Case
  alias Rudy.HTTP

  describe "parse_request/1" do
    test "returns a three-element tuple with in form of {request, headers, body}" do
      {{:get, "/index.html", :v11}, "foo 34", "Hello"} =
        HTTP.parse_request("GET /index.html HTTP/1.1\r\nfoo 34\r\n\r\nHello")
    end
  end
end

defmodule Rudy.HTTP do
  def parse_request(request_0) do
    {request, request_1} = request_line(request_0)
    {headers, request_2} = headers(request_1)
    {body, _} = message_body(request_2)

    {request, headers, body}
  end

  defp request_line("GET " <> request_0) do
    {uri, request_1} = request_uri(request_0)
    {ver, request_2} = http_version(request_1)
    "\r\n" <> request_3 = request_2

    {{:get, uri, ver}, request_3}
  end

  defp request_uri(" " <> request_0), do: {"", request_0}

  defp request_uri(<<c::binary-size(1), request_0::binary>>) do
    {rest, request_1} = request_uri(request_0)

    {c <> rest, request_1}
  end

  defp http_version("HTTP/1.1" <> request_0), do: {:v11, request_0}

  defp http_version("HTTP/1.0" <> request_0), do: {:v10, request_0}

  defp headers("\r\n" <> request_0), do: {"", request_0}

  defp headers("\n" <> request_0), do: {"", request_0}

  defp headers(request_0) do
    {header, request_1} = header(request_0)
    {rest, request_2} = headers(request_1)

    {header <> rest, request_2}
  end

  defp header("\r\n" <> request_0), do: {"", request_0}
  defp header("\n\n" <> request_0), do: {"", request_0}

  defp header(<<c::binary-size(1), request_0::binary>>) do
    {rest, request_1} = header(request_0)
    {c <> rest, request_1}
  end

  defp message_body(request), do: {request, ""}

  def ok(body), do: "HTTP/1.1 200 OK\r\n" <> "\r\n" <> body

  def get(uri), do: "GET" <> uri <> " HTTP/1.1\r\n" <> "\r\n"
end

defmodule Rudy.Server do
  alias Rudy.HTTP

  def init(port) do
    case :gen_tcp.listen(port, [:list, active: false, reuseaddr: true]) do
      {:ok, listen_socket} ->
        handler(listen_socket)
        :gen_tcp.close(listen_socket)
        :ok

      {:error, error} ->
        error
    end
  end

  def handler(listen_socket) do
    case :gen_tcp.accept(listen_socket) do
      {:ok, client} ->
        request(client)

      {:error, error} ->
        error
    end
  end

  def request(client) do
    case :gen_tcp.recv(client, 0) do
      {:ok, request} ->
        response =
          request
          |> to_string()
          |> HTTP.parse_request()
          |> reply()

        :gen_tcp.send(client, response)

      {:error, error} ->
        IO.inspect("rudy: error: #{error}")
    end

    :gen_tcp.close(client)
  end

  def reply({{:get, uri, _http_version}, headers, message_body}) do
    HTTP.ok("""
    URI          -> #{uri}

    HEADERS      -> #{headers}

    MESSAGE BODY -> #{message_body}
    """)
  end
end

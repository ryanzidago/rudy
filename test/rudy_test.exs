defmodule RudyTest do
  use ExUnit.Case
  doctest Rudy

  test "greets the world" do
    assert Rudy.hello() == :world
  end
end

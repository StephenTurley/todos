defmodule TdTest do
  use ExUnit.Case
  doctest Td

  test "greets the world" do
    assert Td.hello() == :world
  end
end

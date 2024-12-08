defmodule TextClientTest do
  use ExUnit.Case
  doctest TextClient

  @tag timeout: :infinity
  test "greets the world" do
    assert TextClient.start() == :ok
  end
end

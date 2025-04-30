defmodule NodesDemoTest do
  use ExUnit.Case
  doctest NodesDemo

  test "greets the world" do
    assert NodesDemo.hello() == :world
  end
end

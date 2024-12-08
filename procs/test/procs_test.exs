defmodule ProcsTest do
  use ExUnit.Case

  import ExUnit.CaptureIO
  doctest Procs

  test "greets the world" do
    assert capture_io(fn ->
      Procs.hello("Alice")
    end) == "hello Alice\n"
  end
end

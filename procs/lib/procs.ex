defmodule Procs do
  @moduledoc """
  A module demonstrating basic process behavior with delayed output.

  This module provides functionality for printing delayed greetings,
  useful for understanding process execution and timing in Elixir.
  """

  @doc """
  Prints a greeting to the given name after a 1-second delay.

  ## Parameters

    * `name` - The name to include in the greeting message

  ## Examples

      iex> import ExUnit.CaptureIO
      iex> capture_io(fn -> Procs.hello("Alice") end)
      "hello Alice\\n"

  """ 
  def hello(name) do
    Process.sleep(1000)
    IO.puts("hello #{name}")
  end
end

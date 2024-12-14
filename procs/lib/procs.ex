defmodule Procs do
  @moduledoc """
  A module demonstrating basic process behavior with delayed output.

  This module provides functionality for printing delayed greetings,
  useful for understanding process execution and timing in Elixir.
  """

  @doc """
  Receives a message then prints it.

  ## Parameters

    * `name` - The name to include in the greeting message

  ## Examples

      iex> import ExUnit.CaptureIO
      iex> capture_io(fn -> Procs.hello("Alice") end)
      "hello Alice\\n"

  """ 
  def hello(count) do
    receive do
      { :crash, reason } ->
        exit(reason)
      { :quit } ->
        IO.puts "I'm outta here"
      { :add, n } ->
        hello(count + n)
      msg ->
        IO.puts("#{count}: Hello #{inspect msg}")
        hello(count)
    end
  end

  def greeting(count) do
    receive do
      { :quit } ->
        IO.puts "I'm outta here"
      { :reset } -> 
        greeting(0)
      { :add, n } ->
        greeting(count + n)
      msg ->
        IO.puts("#{count}: Hello #{inspect msg}")
        greeting(count + 1)
    end
  end
end

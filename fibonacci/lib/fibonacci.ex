defmodule Fibonacci do
  @type t :: pid
  @me __MODULE__

  alias Fibonacci.Cache, as: Cache

  def start_link do
    Agent.start_link(fn -> %{ 0=> 0, 1 => 1 } end, name: @me)
  end

  @spec fib(n :: integer) :: integer
  def fib(n) do
    Cache.run(@me, fn cache ->
      cached_fib(n, cache)
    end)
  end

  def cached_fib(n, cache) do
    Cache.lookup(cache, n, fn ->
      cached_fib(n-2, cache) + cached_fib(n-1, cache)
    end)
  end
end

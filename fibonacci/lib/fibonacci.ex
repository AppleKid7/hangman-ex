defmodule Fibonacci do

  alias Fibonacci.Cache, as: Cache

  def fib(n) do
    Cache.run(fn cache ->
      cached_fib(n, cache)
    end)
  end

  def cached_fib(n, cache) do
    Cache.lookup(cache, n, fn ->
      cached_fib(n-2, cache) + cached_fib(n-1, cache)
    end)
  end
end

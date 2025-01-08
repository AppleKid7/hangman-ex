defmodule Fibonacci do

  alias Fibonacci.Cache, as: Cache

  @type t :: pid
  @me __MODULE__

  def start_link do
    # TODO find a way to implement Agent start
  end

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

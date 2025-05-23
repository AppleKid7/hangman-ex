defmodule Fibonacci.Cache do
  def run(pid, body) do
    result = body.(pid)
    # Agent.stop(@me)
    result
  end

  def lookup(cache, n, if_not_found) do
    Agent.get(cache, fn map -> map[n] end)
    |> complete_if_not_found(cache, n, if_not_found)
  end

  defp complete_if_not_found(nil, cache, n, if_not_found) do
    if_not_found.()
    |> set(cache, n)
  end

  defp complete_if_not_found(value, _cache,  _n, _if_not_found) do
    value
  end

  defp set(value, cache, n) do
    Agent.get_and_update(cache, fn map ->
      { value, Map.put(map, n, value) }
    end) 
  end
end

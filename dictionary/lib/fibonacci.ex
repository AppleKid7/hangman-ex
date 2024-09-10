defmodule Fibonacci do
  def fib(n) do
    loop(0, n, [])
  end

  defp loop(step, n, acc) do
    case {step, acc} do
      {^n, _} ->
        Enum.reverse(acc)

      {0, _} ->
        loop(step + 1, n, [0 | acc])

      {1, _} ->
        loop(step + 1, n, [1 | acc])

      {_, [x, y | _]} ->
        loop(step + 1, n, [x + y | acc])

      _ ->
        # This case is for type safety and should never occur
        acc
    end
  end
end

# Example usage
# IO.inspect Fibonacci.fib(10)

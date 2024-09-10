defmodule Lists do
  # [] = 0
  # [ 1, 3, 5 ] = 3
  @spec len(list(any())) :: non_neg_integer()
  def len([]), do: 0
  def len([_h | t]), do: 1 + len(t)

  @spec sum([any()]) :: any()
  def sum([]), do: 0
  def sum([h | t]), do: do_sum(h, t)
  @spec do_sum(any(), [number()]) :: any()
  defp do_sum(acc, []), do: acc
  defp do_sum(acc, [h | t]), do: do_sum(acc + h, t)

  @spec square([number]) :: [any]
  def square([]), do: []
  def square([h | t]), do: do_square([h * h], t)

  @spec do_square([number(), ...], [number()]) :: [any()]
  defp do_square(squared_list, []), do: Enum.reverse(squared_list)
  defp do_square(squared_list, [h | t]), do: do_square([h * h | squared_list], t)

  @spec double([number()]) :: list(any())
  def double([]), do: []
  def double([h | t]), do: do_double([2 * h], t)
  @spec do_double([number(), ...], [number()]) :: [any()]
  defp do_double(doubled_list, []), do: Enum.reverse(doubled_list)
  defp do_double(doubled_list, [h | t]), do: do_double([2 * h | doubled_list], t)

  @spec sum_pairs([number()]) :: list(any)
  def sum_pairs(list) when rem(length(list), 2) == 0, do: do_sum_pairs(list, [])

  def sum_pairs(_list) do
    raise ArgumentError, "This list must have an even number of elements"
  end

  @spec do_sum_pairs([number()], [number()]) :: list(any)
  defp do_sum_pairs([], acc), do: Enum.reverse(acc)
  defp do_sum_pairs([h1, h2 | t], acc), do: do_sum_pairs(t, [h1 + h2 | acc])

  @spec map([any()], (... -> any)) :: [any()]
  def map(l, func), do: do_map(l, func, [])
  @spec do_map([any()], (... -> any), [any()]) :: [any()]
  defp do_map([], func, acc) when is_function(func), do: Enum.reverse(acc)
  defp do_map([h | t], func, acc) when is_function(func), do: do_map(t, func, [func.(h) | acc])
end

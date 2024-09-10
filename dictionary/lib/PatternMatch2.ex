defmodule PatternMatch2 do
  @moduledoc """
  Documentation for `PatternMatch2`.
  """
  def is_equal(a, a) do
    true
  end

  def is_equal(_, _) do
    false
  end
end

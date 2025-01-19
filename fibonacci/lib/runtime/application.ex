defmodule Fibonacci.Runtime.Application do
  use Application

  def start(_type, _args) do
    Fibonacci.start_link()
  end

  def run(n) do
    Fibonacci.fib(n)
  end

end

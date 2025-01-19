defmodule Fibonacci.Runtime.Application do
  use Application

  def start(_type, _args) do
    children = [
      { Fibonacci, []},
    ]

    options = [
      name: Fibonacci.Supervisor,
      strategy: :one_for_one,
    ]

    Supervisor.start_link(children, options)
  end

  def run(n) do
    Fibonacci.fib(n)
  end

end

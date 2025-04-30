defmodule Hangman do
  alias Hangman.Runtime.Server, as: Server
  alias Hangman.Type, as: Type

  @opaque game :: Server.t
  @type tally :: Type.tally
  @type word :: String.t()

  @spec new_game() :: game
  def new_game() do
    { :ok, pid } = Hangman.Runtime.Application.start_game
    IO.puts("New game started: #{inspect(pid)}")
    pid
  end

  @spec make_move(game, word) :: Type.tally()
  def make_move(game, guess) do
    GenServer.call(game, { :make_move, guess })
  end

  @spec tally(game) :: Type.tally()
  def tally(game) do
    GenServer.call(game, { :tally })
  end
end

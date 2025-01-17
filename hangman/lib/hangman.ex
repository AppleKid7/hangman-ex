defmodule Hangman do
  alias Hangman.Runtime.Server, as: Server
  alias Hangman.Type, as: Type

  @opaque game :: Server.t
  @type tally :: Type.tally
  @type word :: String.t()

  @spec new_game() :: game
  def new_game() do
    { :ok, pid } = Server.start_link()
    pid
  end

  @spec make_move(game, word) :: {game, Type.tally()}
  def make_move(game, guess) do
    GenServer.call(game, { :make_move, guess })
  end

  @spec tally(game) :: Type.tally()
  def tally(game) do
    GenServer.call(game, { :tally })
  end
end

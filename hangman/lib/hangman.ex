defmodule Hangman do
  alias Hangman.Impl.Game, as: Game
  alias Hangman.Type, as: Type

  @opaque game :: Game.t()
  @type word :: String.t()

  @spec new_game() :: game
  defdelegate new_game, to: Game, as: :new_game

  @spec make_move(game, word) :: {game, Type.tally()}
  defdelegate make_move(game, guess), to: Game, as: :make_move

  @spec tally(game) :: Type.tally()
  defdelegate tally(game), to: Game
end
